//
//  DirectoryIndicator.swift
//  
//
//  Created by Ian Sampson on 2021-11-22.
//

struct DirectoryIndicator: Parsable {
    static func parse(_ input: Substring) throws -> Parse<()> {
        guard input.prefix(3) == "10." else {
            throw ParseError.expectedDirectoryIndicator
        }
        return .init(remainingInput: input.dropFirst(3), output: ())
    }
}
