//
//  DOITests.swift
//
//
//  Created by Ian Sampson on 2021-11-22.
//

import XCTest
@testable import DOI

final class DOITests: XCTestCase {
    func testParseDOI() throws {
        // When
        let doi = try DOI(string: "10.123/456")
        
        // Then
        XCTAssertEqual(doi.string, "10.123/456")
    }
    
    func testParseURL() throws {
        // When
        let doiA = try DOI(string: "https://doi.org/10.123/456")
        let doiB = try DOI(string: "https://www.doi.org/10.123/456")
        let doiC = try DOI(string: "http://doi.org/10.123/456")
        let doiD = try DOI(string: "doi.org/10.123/456")
        let doiE = try DOI(string: "www.doi.org/10.123/456")
        
        // Then
        for doi in [doiA, doiB, doiC, doiD, doiE] {
            XCTAssertEqual(doi.string, "10.123/456")
            XCTAssertEqual(doi.url.absoluteString, "https://doi.org/10.123/456")
        }
    }
    
    func testParsePercentEncodedURL() throws {
        // When
        let doi = try DOI(string: "https://doi.org/10.1000/456%23789")
        
        // Then
        XCTAssertEqual(doi.url.absoluteString, "https://doi.org/10.1000/456%23789")
        XCTAssertEqual(doi.string, "10.1000/456#789")
    }
}
