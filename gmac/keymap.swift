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

func keymapTable(code: UInt8) -> String {
    var key: String {
        switch (code) {
            
        // USB HID usage table
        // http://www.freebsddiary.org/APC/usb_hid_usages.php
        // This work was obtained from riccardo@torrini.org
            
        case 0x00: return "Reserved (no event indicated)"
        case 0x01: return "ErrorRollOver"
        case 0x02: return "POSTFail"
        case 0x03: return "ErrorUndefined"
        case 0x04: return "a and A"
        case 0x05: return "b and B"
        case 0x06: return "c and C"
        case 0x07: return "d and D"
        case 0x08: return "e and E"
        case 0x09: return "f and F"
        case 0x0A: return "g and G"
        case 0x0B: return "h and H"
        case 0x0C: return "i and I"
        case 0x0D: return "j and J"
        case 0x0E: return "k and K"
        case 0x0F: return "l and L"
        case 0x10: return "m and M"
        case 0x11: return "n and N"
        case 0x12: return "o and O"
        case 0x13: return "p and P"
        case 0x14: return "q and Q"
        case 0x15: return "r and R"
        case 0x16: return "s and S"
        case 0x17: return "t and T"
        case 0x18: return "u and U"
        case 0x19: return "v and V"
        case 0x1A: return "w and W"
        case 0x1B: return "x and X"
        case 0x1C: return "y and Y"
        case 0x1D: return "z and Z"
        case 0x1E: return "1 and !"
        case 0x1F: return "2 and @"
        case 0x20: return "3 and #"
        case 0x21: return "4 and $"
        case 0x22: return "5 and %"
        case 0x23: return "6 and ^"
        case 0x24: return "7 and &"
        case 0x25: return "8 and *"
        case 0x26: return "9 and ("
        case 0x27: return "0 and )"
        case 0x28: return "Return (ENTER)"
        case 0x29: return "ESCAPE"
        case 0x2A: return "DELETE (Backspace)"
        case 0x2B: return "Tab"
        case 0x2C: return "Spacebar"
        case 0x2D: return "- and (underscore)"
        case 0x2E: return "= and +"
        case 0x2F: return "[ and {"
        case 0x30: return "] and }"
        case 0x31: return "\\ and |"
        case 0x32: return "Non-US # and ~"
        case 0x33: return "; and :"
        case 0x34: return "' and \""
        case 0x35: return "Grave Accent and Tilde"
        case 0x36: return " and <"
        case 0x37: return ". and >"
        case 0x38: return "/ and ?"
        case 0x39: return "Caps Lock"
        case 0x3A: return "F1"
        case 0x3B: return "F2"
        case 0x3C: return "F3"
        case 0x3D: return "F4"
        case 0x3E: return "F5"
        case 0x3F: return "F6"
        case 0x40: return "F7"
        case 0x41: return "F8"
        case 0x42: return "F9"
        case 0x43: return "F10"
        case 0x44: return "F11"
        case 0x45: return "F12"
        case 0x46: return "PrintScreen"
        case 0x47: return "Scroll Lock"
        case 0x48: return "Pause"
        case 0x49: return "Insert"
        case 0x4A: return "Home"
        case 0x4B: return "PageUp"
        case 0x4C: return "Delete Forward"
        case 0x4D: return "End"
        case 0x4E: return "PageDown"
        case 0x4F: return "RightArrow"
        case 0x50: return "LeftArrow"
        case 0x51: return "DownArrow"
        case 0x52: return "UpArrow"
        case 0x53: return "NUM Num Lock and Clear"
        case 0x54: return "NUM /"
        case 0x55: return "NUM *"
        case 0x56: return "NUM -"
        case 0x57: return "NUM +"
        case 0x58: return "NUM ENTER"
        case 0x59: return "NUM 1 and End"
        case 0x5A: return "NUM 2 and Down Arrow"
        case 0x5B: return "NUM 3 and PageDn"
        case 0x5C: return "NUM 4 and Left Arrow"
        case 0x5D: return "NUM 5"
        case 0x5E: return "NUM 6 and Right Arrow"
        case 0x5F: return "NUM 7 and Home"
        case 0x60: return "NUM 8 and Up Arrow"
        case 0x61: return "NUM 9 and PageUp"
        case 0x62: return "NUM 0 and Insert"
        case 0x63: return "NUM . and Delete"
        case 0x64: return "Non-US \\ and |"
        case 0x65: return "Application"
        case 0x66: return "Power"
        case 0x67: return "NUM ="
        case 0x68: return "F13"
        case 0x69: return "F14"
        case 0x6A: return "F15"
        case 0x6B: return "F16"
        case 0x6C: return "F17"
        case 0x6D: return "F18"
        case 0x6E: return "F19"
        case 0x6F: return "F20"
        case 0x70: return "F21"
        case 0x71: return "F22"
        case 0x72: return "F23"
        case 0x73: return "F24"
        case 0x74: return "Execute"
        case 0x75: return "Help"
        case 0x76: return "Menu"
        case 0x77: return "Select"
        case 0x78: return "Stop"
        case 0x79: return "Again"
        case 0x7A: return "Undo"
        case 0x7B: return "Cut"
        case 0x7C: return "Copy"
        case 0x7D: return "Paste"
        case 0x7E: return "Find"
        case 0x7F: return "Mute"
        case 0x80: return "Volume Up"
        case 0x81: return "Volume Down"
        case 0x82: return "Locking Caps Lock"
        case 0x83: return "Locking Num Lock"
        case 0x84: return "Locking Scroll Lock"
        case 0x85: return "NUM Comma"
        case 0x86: return "NUM Equal Sign"
        case 0x87: return "International1"
        case 0x88: return "International2"
        case 0x89: return "International3"
        case 0x8A: return "International4"
        case 0x8B: return "International5"
        case 0x8C: return "International6"
        case 0x8D: return "International7"
        case 0x8E: return "International8"
        case 0x8F: return "International9"
        case 0x90: return "LANG1"
        case 0x91: return "LANG2"
        case 0x92: return "LANG3"
        case 0x93: return "LANG4"
        case 0x94: return "LANG5"
        case 0x95: return "LANG6"
        case 0x96: return "LANG7"
        case 0x97: return "LANG8"
        case 0x98: return "LANG9"
        case 0x99: return "Alternate Erase"
        case 0x9A: return "SysReq/Attention"
        case 0x9B: return "Cancel"
        case 0x9C: return "Clear"
        case 0x9D: return "Prior"
        case 0x9E: return "Return"
        case 0x9F: return "Separator"
        case 0xA0: return "Out"
        case 0xA1: return "Oper"
        case 0xA2: return "Clear/Again"
        case 0xA3: return "CrSel/Props"
        case 0xA4: return "ExSel"
        case 0xE0: return "LeftControl"
        case 0xE1: return "LeftShift"
        case 0xE2: return "LeftAlt"
        case 0xE3: return "Left GUI"
        case 0xE4: return "RightControl"
        case 0xE5: return "RightShift"
        case 0xE6: return "RightAlt"
        case 0xE7: return "Right GUI"
        default: return "Unknown"
        }
    }
    
    return key
}

func readInteger<T : IntegerType>(data : NSData, start : Int) -> T {
    var d : T = 0
    data.getBytes(&d, range: NSRange(location: start, length: sizeof(T)))
    return d
}

func matchString(for regex: String!, in text: String!) -> Bool {
    do {
        let regex = try NSRegularExpression(pattern: regex, options: [])
        let nsString = text as NSString
        let results = regex.matchesInString(text, options: [], range: NSMakeRange(0, nsString.length))
        var match = [String]()
        for result in results {
            for i in 0..<result.numberOfRanges {
                match.append(nsString.substringWithRange( result.rangeAtIndex(i) ))
            }
        }
        
        if match.count > 0 {
            return true
        } else {
            return false
        }
    } catch let error as NSError {
        print("invalid regex: \(error.localizedDescription)")
        
        return false
    }
}

func validateKeymap(keymap: String, count: Int) -> Bool {
    var bitmask: [UInt8] = []

    let keys = keymap.componentsSeparatedByString(",")
    for key in keys {
        let pattern: String! = "^0x[0-9a-fA-F]{2}$"

        if matchString(for: pattern, in: key) == false {
            return false
        }
        bitmask.append(key.hexToUInt8)
    }
    
    if bitmask.count == count {
        return true
    }
    
    return false
}

func parseKeymap(keymap: String, bitmask_begin: Int, bitmask_length: Int) -> [UInt8] {
    var bitmask: [UInt8] = []
    
    bitmask.append(UInt8(bitmask_begin))
    
    let keys = keymap.componentsSeparatedByString(",")
    for key in keys {
        bitmask.append(key.hexToUInt8)
    }
    
    while bitmask.count <= bitmask_length {
        bitmask.append(0)
    }
    
    return bitmask
}
