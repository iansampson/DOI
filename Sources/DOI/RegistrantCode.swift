//
//  RegistrantCode.swift
//  
//
//  Created by Ian Sampson on 2021-11-22.
//

struct RegistrantCode: Parsable {
    static func parse(_ input: Substring) throws -> Parse<Substring> {
        var remainingInput = input
        while let character = remainingInput.popFirst() {
            if character == "/" {
                return .init(remainingInput: remainingInput,
                             output: input[input.startIndex..<remainingInput.startIndex].dropLast())
            }
        }
        throw ParseError.expectedForwardSlashAfterRegistrantCode
    }
}
