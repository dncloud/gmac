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

let doc : String = "gmap app\n" +
    "\n" +
    "Usage:\n" +
    "  gmac -m MODEL -r\n" +
    "  gmac -m MODEL -w KEYMAP\n" +
    "  gmac (-t | --table)\n" +
    "  gmac (-d | --donate)\n" +
    "  gmac (-h | --help)\n" +
    "  gmac --version\n" +
    "\n" +
    "Options:\n" +
    "  -m --model    Logitech G510 and G710 are currenty supported.\n" +
    "  -r --read     Read keymap from the keyboard\n" +
    "  -w --write    Write keymap to the keyboard\n" +
    "  -t --table    Show USB HID usage table for keyboards\n" +
    "  -d --donate   Makes me happy\n" +
    "  -h --help     Show this screen\n" +
    "\n" +
    "Example:\n" +
    "  gmac -m G710 -w 0x3a,0x3b,0x3b,0x3d,0x0e,0x13\n" +
    "  writes G1=F1, G2=F2, G3=F3, G4=F4, G5=K, G6=P\n" +
    "\n" +
    "Keymap:\n" +
    " G710 format: 0xff,0xff,0xff,0xff,0xff,0xff\n" +
    " G510 format: 0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,\n" +
    "              0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff\n" +
    "\n" +
    "created with ❤️  by Oliver Cermann\n\n"

var args = Process.arguments; args.removeAtIndex(0)
let result = Docopt.parse(doc, argv: args, help: true, version: "gmap 0.1", optionsFirst: false)

let model: AnyObject = result["MODEL"]!
let keymap: AnyObject = result["KEYMAP"]!
let opt_model: Bool = result["--model"] as! Bool
let opt_write: Bool = result["--write"] as! Bool
let opt_read: Bool = result["--read"] as! Bool
let opt_table: Bool = result["--table"] as! Bool
let opt_donate: Bool = result["--donate"] as! Bool

if opt_write {
    if !validateModel(model) {
        print(doc); exit(0)
    }

    let keyboard = getModel(model as! String)
    let name = (keyboard?.name)!
    let vendorID = (keyboard?.vendorID)!
    let productID = (keyboard?.productID)!
    let reportID = (keyboard?.reportID)!
    let button_count = (keyboard?.button_count)!
    let bitmask_begin = (keyboard?.bitmask_begin)!
    let bitmask_length = (keyboard?.bitmask_length)!
    
    if !validateKeymap(keymap as! String, count: button_count) {
        print(doc); exit(0)
    }

    log("I \(name)!")
    
    let bitmask = parseKeymap(keymap as! String, bitmask_begin: bitmask_begin, bitmask_length: bitmask_length)
    
    let hid = HID(vendorID: vendorID, productID: productID)
    let device = hid.create()
    
    if device != nil {
        hid.write(device!, reportID: reportID, bitmask: bitmask)

        log("I Keymap")
        var index = 1
        for key in keymap.componentsSeparatedByString(",") {
            log(" = G\(index) is now \(keymapTable(key.hexToUInt8))")
            index += 1
        }
    }
    
    exit(0)
}

if opt_read {
    if !validateModel(model) {
        print(doc); exit(0)
    }
    
    let keyboard = getModel(model as! String)
    let name = (keyboard?.name)!
    let vendorID = (keyboard?.vendorID)!
    let productID = (keyboard?.productID)!
    let reportID = (keyboard?.reportID)!
    let button_count = (keyboard?.button_count)!
    let bitmask_begin = (keyboard?.bitmask_begin)!
    let bitmask_length = (keyboard?.bitmask_length)!
    
    log("I \(name)!")
    let hid = HID(vendorID: vendorID, productID: productID)
    let device = hid.create()
    
    if device != nil {
        let data = hid.read(device!, reportID: reportID)
        
        let count = data!.length / sizeof(UInt8)
        var keymap = [UInt8](count: count, repeatedValue: 0)
        
        data!.getBytes(&keymap, length:count * sizeof(UInt8))

        log("I Keymap")
        var index = 0
        for key in keymap {
            if index != 0 {
                log(" = G\(index) is \(keymapTable(key))")
            }
            
            if index == button_count {
                break
            }

            index += 1
        }
    }
}

if opt_table {
    for i: UInt8 in 0..<255 {
        if keymapTable(i) != "Unknown" {
            print("0x\(String(format:"%02X", i)): \(keymapTable(i))")
        }
    }
    
    exit(1)
}

if opt_donate {
    print("Thanks for your support!\n\n    To help make more projects like this, i need more coffee.\n")
    print("    Bitcoin: 1BDsQVVLqbm7bwRqjA7qk4BPyUFp82cAAp\n")
}
