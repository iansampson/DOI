//
//  Parsable.swift
//
//
//  Created by Ian Sampson on 2020-05-22.
//

protocol Parsable {
    associatedtype Output
    static func parse(_ input: Substring) throws -> Parse<Output>
}

struct Parse<Output> {
    let remainingInput: Substring
    let output: Output
}
