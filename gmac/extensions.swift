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

extension String {
    func regex (pattern: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions(rawValue: 0))
            let nsstr = self as NSString
            let all = NSRange(location: 0, length: nsstr.length)
            var matches : [String] = [String]()
            regex.enumerateMatchesInString(self, options: NSMatchingOptions(rawValue: 0), range: all) {
                (result : NSTextCheckingResult?, _, _) in
                if let r = result {
                    let result = nsstr.substringWithRange(r.range) as String
                    matches.append(result)
                }
            }
            return matches
        } catch {
            return [String]()
        }
    }
}

extension Array {
    func get(index: Int) -> Element? {
        if 0 <= index && index < count {
            return self[index]
        } else {
            return nil
        }
    }
}

extension NSData {
    public convenience init(hexString: String) {
        var index = hexString.startIndex
        var bytes: [UInt8] = []
        repeat {
            bytes.append(hexString[index...index.advancedBy(1)].withCString {
                return UInt8(strtoul($0, nil, 16))
                })
            
            index = index.advancedBy(2)
        } while index.distanceTo(hexString.endIndex) != 0
        
        self.init(bytes: &bytes, length: bytes.count)
    }
}

extension String {
    var dropHexPrefix: String {
        return hasPrefix("0x") ? String(characters.dropFirst(2)) : self
    }
    
    var hexToUInt8: UInt8 {
        return UInt8(dropHexPrefix, radix: 16) ?? 0
    }
    
    var hexToInt: Int {
        return Int(dropHexPrefix, radix: 16) ?? 0
    }
}

extension Int {
    var toHexString: String {
        return String(self, radix: 16)
    }
}
