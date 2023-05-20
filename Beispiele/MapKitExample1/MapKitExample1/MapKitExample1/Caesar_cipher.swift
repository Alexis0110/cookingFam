//
//  Caesar_cipher.swift
//  Caesar_Command
//
//  Created by Miriam Föller-Nord on 15.12.22.
//

import Foundation
let numChars = 26
let startCharNum = 65
let endCharNum = 90

// calculates Modulo correctly also with negative dividend
func modulo (_ a: Int, _ n: Int) -> Int{
    let r = a % n
    return r >= 0 ? r : r + n
}


func encrypt(_ message: String, key: Int) -> String {
    let upperMessage = message.uppercased()
    var asciiValue:Int
    var encrypted = ""

    for char in upperMessage {
        // Abfage ob wirklich ASCII-Wert
        if let ascVal: UInt8 = char.asciiValue{
           asciiValue = Int(ascVal)
        } else {
           asciiValue = 0
        }
        //let asciiValue = Int(char.asciiValue!)
        
        if asciiValue >= startCharNum && asciiValue <= endCharNum {
            let shifted = (asciiValue - startCharNum + key) % numChars + startCharNum
//            print (asciiValue,shifted)
            encrypted.append(Character(UnicodeScalar(shifted)!))
        } else {
            encrypted.append(char)
        }
    }

    return encrypted
}

func decrypt(_ message: String, key: Int) -> String {
// cipher text in uppar case characters
    let upperMessage = message.uppercased()
    var decrypted = ""
    var asciiValue:Int

    for char in upperMessage {
        // hier bfage ob wirklich ASCII-Wert
        if let ascVal: UInt8 = char.asciiValue{
           asciiValue = Int(ascVal)
        } else {
           asciiValue = 0
        }
 
        if asciiValue >= startCharNum && asciiValue <= endCharNum {
            // use user function modulo instead of % because % failed with negative values
            let shifted = modulo((asciiValue - startCharNum - key), numChars) + startCharNum
            decrypted.append(Character(UnicodeScalar(shifted)!))
        } else {
            decrypted.append(char)
        }
    }
// plain text in lower case characters
    return decrypted.lowercased()
}

