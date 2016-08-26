/*
 * gmac - Logitech G510 and G710+ G button support for MacOS
 *
 *
 * The MIT License
 *
 * Copyright © 2016 Oliver Cermann
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import Foundation
import IOKit.hid

class HID {
    let vendorID: Int
    let productID: Int
    var reportSize: Int = 0
    
    init(vendorID: Int, productID: Int) {
        self.vendorID = vendorID
        self.productID = productID
    }
    
    func create() -> IOHIDDevice? {
        log("I Open HID")
        log(" < Read USB device list")
        
        let manager = IOHIDManagerCreate(kCFAllocatorDefault, IOOptionBits(kIOHIDOptionsTypeNone)).takeUnretainedValue()
        
        IOHIDManagerSetDeviceMatching(manager, nil)
        IOHIDManagerOpen(manager, IOOptionBits(kIOHIDOptionsTypeNone))
        
        let devicesSet = IOHIDManagerCopyDevices(manager).takeUnretainedValue()
        
        let devicesCount = CFSetGetCount(devicesSet)
        let devices = UnsafeMutablePointer<UnsafePointer<Void>>.alloc(devicesCount)
        
        CFSetGetValues(devicesSet, &devices[0])
        
        log(" > Found \(devicesCount) devices")
        
        log(" < Searching for vendorID: 0x0\(vendorID.toHexString) and productID: 0x0\(productID.toHexString)")
        for i in 0..<devicesCount {
            let dev = unsafeBitCast(devices[i], IOHIDDeviceRef.self)
            
            let productKey = IOHIDDeviceGetProperty(dev, kIOHIDProductKey).takeRetainedValue()
            let vendorIDKey = IOHIDDeviceGetProperty(dev, kIOHIDVendorIDKey).takeRetainedValue()
            let productIDKey = IOHIDDeviceGetProperty(dev, kIOHIDProductIDKey).takeRetainedValue()
            let maxFeatureReportSizeKey = IOHIDDeviceGetProperty(dev, kIOHIDMaxFeatureReportSizeKey).takeRetainedValue()
            
            if vendorIDKey as! Int == vendorID && productIDKey as! Int == productID{
                if maxFeatureReportSizeKey as! Int > 0 {
                    log("   > Found \(productKey)")
                    
                    let device: IOHIDDevice? = dev
                    
                    log("   < Set reportSize automatically to \(maxFeatureReportSizeKey)")
                    reportSize = maxFeatureReportSizeKey as! Int
                    
                    return device
                }
            }
        }
        log(" > Can't found your keyboard.")
        log("I Aborting...")

        return nil
    }
    
    func read(device: IOHIDDevice, reportID: Int) -> NSData? {
        log("I Read")
        log(" < Try to open your keyboard...")
        let open = IOHIDDeviceOpen(device, IOOptionBits(kIOHIDOptionsTypeSeizeDevice))
        
        if open == kIOReturnSuccess {
            log(" = Success")
            let buffer = UnsafeMutablePointer<UInt8>.alloc(reportSize)
            var report: CFIndex = reportSize
            
            log(" < Reading data...")
            IOHIDDeviceGetReport(device, kIOHIDReportTypeFeature, reportID, buffer, &report)
            log(" = Success")

            return NSData(bytes:buffer, length:report)
        }
        
        return nil
    }
    
    func write(device: IOHIDDevice, reportID: Int, bitmask: [UInt8]) -> NSData? {
        log("I Write")
        log(" < Try to open your keyboard...")
        let open = IOHIDDeviceOpen(device, IOOptionBits(kIOHIDOptionsTypeSeizeDevice))
        
        if open == kIOReturnSuccess {
            log(" = Success")
            let data = NSData(bytes:bitmask, length:bitmask.count)
            
            log(" < Writing data...")
            IOHIDDeviceSetReport(device, kIOHIDReportTypeFeature, reportID, UnsafePointer<UInt8>(data.bytes), data.length)
            log(" = Success")
        }
        
        return self.read(device, reportID: reportID)
    }
}
