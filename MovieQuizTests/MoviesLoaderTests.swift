//
//  MoviesLoaderTests.swift
//  MovieQuiz
//
//  Created by Amir on 06.06.2026.
//
import XCTest
@testable import MovieQuiz

//class MoviesLoaderTests: XCTestCase{
//    func testSuccessLoading() throws{
//        // Given
//        let stubNetworkClient = StubNetworkClient(emulateError: false)
//        let loader = MoviesLoader(networkClient: stubNetworkClient)
//        
//        // When
//        let expectation = expectation(description: "Loading expectation")
//        
//        // Then
//        loader.loadMovies { result in
//            switch result {
//            case .success(let movies):
//                XCTAssertEqual(movies.items.count, 2)
//                expectation.fulfill()
//            case .failure(let failure):
//                XCTFail("Unexpected failure")
//            }
//        }
//        
//        
//        waitForExpectations(timeout: 1)
//    }
//    
//    
//    func testFailureLoading() throws{
//        
//        // Given
//        let stubNetworkClient = StubNetworkClient(emulateError: true)
//        let loader = MoviesLoader(networkClient: stubNetworkClient)
//        
//        // When
//        let expectation = expectation(description: "Loading expectation")
//        
//        // Then
//        loader.loadMovies{result in
//            switch result {
//            case .success(let movies):
//                XCTAssertNotNil(movies)
//                expectation.fulfill()
//            case .failure(let error):
//                XCTFail("Unexpected failure")
//            }
//        }
//        
//        waitForExpectations(timeout: 1)
//
//    }
//}
