//
//  LowercaseASCII.swift
//  
//
//  Created by Ian Sampson on 2021-11-22.
//

extension StringProtocol {
    // TODO: Make this function more efficient
    func lowercasedASCII() -> String {
        var string = ""
        for character in self {
            if character.isASCII {
                string += character.lowercased()
            } else {
                string.append(character)
            }
        }
        return string
    }
}
