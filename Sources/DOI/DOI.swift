//
//  DOI.swift
//  
//
//  Created by Ian Sampson on 2021-11-22.
//

import Foundation

// TODO: Write readme
// TODO: Allow (optionally) restricting special characters
//   https://www.doi.org/doi_handbook/2_Numbering.html
//   See Table 1 and 2
// TODO: Percent-encode forward slash in registrant code
// (in case the caller obtains a string from a DOI
// with a percent-encoded slash in the prefix
// and then tries to construct another DOI with that string,
// e.g. during encoding and decoding to JSON)
// TODO: Improve error-handling (especially when URL parsing fails)

public struct DOI: Hashable {
    public let registrantCode: String
    public let suffix: String
    
    public init<S>(_ string: S) throws where S: StringProtocol, S.SubSequence == Substring {
        let string = String(string)
        if let url = URL(string: string) {
            if url.host == "doi.org" || url.host == "www.doi.org",
               url.scheme == "https" || url.scheme == "http" {
                let string = String(url.path.dropFirst())
                self = try Self.init(string)
                return
            } else if url.pathComponents.first == "doi.org" || url.pathComponents.first == "www.doi.org" {
                let string = url.pathComponents.dropFirst().joined(separator: "/")
                self = try Self.init(string)
                return
            }
        }
        
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
    public var string: String {
        "10.\(registrantCode)/\(suffix)"
    }
    
    public func string(includingLabel: Bool) -> String {
        if includingLabel {
            return "doi:10.\(registrantCode)/\(suffix)"
        } else {
            return string
        }
    }
    
    public var url: URL {
        guard let url = URL(string: "https://doi.org")?
                .appendingPathComponent(string)
        else {
            fatalError()
        }
        return url
    }
}

extension DOI: CustomStringConvertible {
    public var description: String {
        string(includingLabel: true)
    }
}
