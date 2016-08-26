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

struct Keyboard {
    let name: String            // Modelname e.g. G510, G710...
    let vendorID: Int           // VendorID Logitech
    let productID: Int          // ProductID e.g. G510, G710...
    let reportID: Int           // ReportID CFIndex
    let bitmask_begin: Int      // First value from the bitmask
    let bitmask_length: Int     // Bitmask length
    let button_count: Int       // G-Button count
}

func G510() -> Keyboard {
    let name = "Logitech G510"
    let vendorID = 0x046d
    let productID = 0xc22d
    let reportID = 0x0301
    let bitmask_begin = 0x01
    let bitmask_length = 18
    let button_count = 18

    return Keyboard.init(name: name, vendorID: vendorID, productID: productID, reportID: reportID,
                         bitmask_begin: bitmask_begin, bitmask_length: bitmask_length, button_count: button_count)
}

func G710() -> Keyboard {
    let name = "Logitech G710"
    let vendorID = 0x046d
    let productID = 0xc24d
    let reportID = 0x0309
    let bitmask_begin = 0x09
    let bitmask_length = 12
    let button_count = 6
    
    return Keyboard.init(name: name, vendorID: vendorID, productID: productID, reportID: reportID,
                         bitmask_begin: bitmask_begin, bitmask_length: bitmask_length, button_count: button_count)
}

enum Models: String {
    case G510 = "G510"
    case G710 = "G710"
}

func validateModel(model: AnyObject) -> Bool {
    if (Models.init(rawValue: model as! String) != nil) {
        return true
    } else {
        return false
    }
}

func getModel(model: String) -> Keyboard? {
    switch model {
    case "G510":
        return G510()
    case "G710":
        return G710()
    default:
        return nil
    }
}
