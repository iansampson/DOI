//
//  DOI.swift
//  
//
//  Created by Ian Sampson on 2021-11-22.
//

import Foundation

struct DOI {
    let registrantCode: String
    let suffix: String
    
    init(string: String) throws {
        let input = string[...]
        let resultA = try OptionalLabel.parse(input)
        let resultB = try DirectoryIndicator.parse(resultA.remainingInput)
        let resultC = try RegistrantCode.parse(resultB.remainingInput)
        let resultD = try Suffix.parse(resultC.remainingInput)
        
        guard let registrantCode = resultC.output
                .lowercasedASCII()
                .removingPercentEncoding,
              let suffix = resultD.output
                .lowercasedASCII()
                .removingPercentEncoding
        else {
            fatalError()
        }
        
        self.registrantCode = registrantCode
        self.suffix = suffix
    }
    
    // TODO: Allow different formats
    var string: String {
        "10.\(registrantCode)/\(suffix)"
    }
}

// Parse doi:
// parse https://doi.org //

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

enum ParseError: Error {
    case expectedDirectoryIndicator
    case expectedForwardSlashAfterRegistrantCode
}

struct OptionalLabel: Parsable {
    static func parse(_ input: Substring) throws -> Parse<()> {
        guard input.prefix(4) == "doi:" else {
            return .init(remainingInput: input, output: ())
        }
        return .init(remainingInput: input.dropFirst(4), output: ())
    }
}

struct DirectoryIndicator: Parsable {
    static func parse(_ input: Substring) throws -> Parse<()> {
        guard input.prefix(3) == "10." else {
            throw ParseError.expectedDirectoryIndicator
        }
        return .init(remainingInput: input.dropFirst(3), output: ())
    }
}

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
