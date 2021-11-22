//
//  DOITests.swift
//
//
//  Created by Ian Sampson on 2021-11-22.
//

import XCTest
import DOI

final class DOITests: XCTestCase {
    func testParseDOI() throws {
        // When
        let doi = try DOI("10.123/456")
        
        // Then
        XCTAssertEqual(doi.string, "10.123/456")
        XCTAssertEqual(doi.registrantCode, "123")
        XCTAssertEqual(doi.suffix, "456")
    }
    
    func testParseURL() throws {
        // When
        let doiA = try DOI("https://doi.org/10.123/456")
        let doiB = try DOI("https://www.doi.org/10.123/456")
        let doiC = try DOI("http://doi.org/10.123/456")
        let doiD = try DOI("doi.org/10.123/456")
        let doiE = try DOI("www.doi.org/10.123/456")
        
        // Then
        for doi in [doiA, doiB, doiC, doiD, doiE] {
            XCTAssertEqual(doi.string, "10.123/456")
            XCTAssertEqual(doi.url.absoluteString, "https://doi.org/10.123/456")
        }
    }
    
    func testParsePercentEncodedURL() throws {
        // When
        let doi = try DOI("https://doi.org/10.1000/456%23789")
        
        // Then
        XCTAssertEqual(doi.url.absoluteString, "https://doi.org/10.1000/456%23789")
        XCTAssertEqual(doi.string, "10.1000/456#789")
    }
    
    func testEncodeAndDecodeDOI() throws {
        // Given
        let string = "\"doi:10.123\\/456\""
        guard let data = string.data(using: .utf8) else {
            fatalError()
        }
        
        // When
        let doi = try JSONDecoder().decode(DOI.self, from: data)
        let encodedDOI = try JSONEncoder().encode(doi)
        
        // Then
        XCTAssertEqual(doi.string, "10.123/456")
        XCTAssertEqual(encodedDOI, data)
    }
}
