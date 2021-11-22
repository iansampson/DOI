//
//  Suffix.swift
//  
//
//  Created by Ian Sampson on 2021-11-22.
//

struct Suffix: Parsable {
    static func parse(_ input: Substring) throws -> Parse<Substring> {
        var remainingInput = input
        while let _ = remainingInput.popFirst() {
            // TODO: Check for disallowed characters
            // https://www.doi.org/doi_handbook/2_Numbering.html
            // See Table 1 and 2
        }
        return .init(remainingInput: remainingInput, output: input)
    }
}
