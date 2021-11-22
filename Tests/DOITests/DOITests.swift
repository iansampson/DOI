//
//  DOITests.swift
//
//
//  Created by Ian Sampson on 2021-11-22.
//

import XCTest
@testable import DOI

final class DOITests: XCTestCase {
    func testExample() throws {
        // When
        let doi = try DOI(string: "10.123/456")
        
        // Then
        XCTAssertEqual(doi.string, "10.123/456")
    }
}
