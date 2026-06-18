//
//  ArrayTests.swift
//  MovieQuiz
//
//  Created by Amir on 06.06.2026.
//
import XCTest
@testable import MovieQuiz

class ArrayTests: XCTestCase{
    func getValueInRange() throws {
        let array = [1,1,2,3,5]
        
        let value = array[safe: 2]
        
        XCTAssertNotNil(value)
        XCTAssertEqual(value, 2)
    }
    
    func getValueOutOfRange() throws {
        let array = [1,1,2,3,5]
        
        let value = array[safe: 2]
        
        XCTAssertNil(value)
    }
}
