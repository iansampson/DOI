//
//  OptionalLabel.swift
//  
//
//  Created by Ian Sampson on 2021-11-22.
//

struct OptionalLabel: Parsable {
    static func parse(_ input: Substring) throws -> Parse<()> {
        guard input.prefix(4) == "doi:" else {
            return .init(remainingInput: input, output: ())
        }
        return .init(remainingInput: input.dropFirst(4), output: ())
    }
}
