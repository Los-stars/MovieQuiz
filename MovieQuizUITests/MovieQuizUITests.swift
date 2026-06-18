//
//  MovieQuizUITests.swift
//  MovieQuizUITests
//
//  Created by Amir on 07.06.2026.
//

import XCTest

final class MovieQuizUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()
        app.launch()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app.terminate()
        app = nil
    }
    
    func testYesButton() throws{
        sleep(3)
        let firstPoster = app.images["Poster"]
        app.buttons["Yes"].tap()
        sleep(3)
        let secondPoster = app.images["Poster"]
        
        let indexLabel = app.staticTexts["Index"]
        
        let firstPosterData = firstPoster.screenshot().pngRepresentation
        let seconfPosterData = secondPoster.screenshot().pngRepresentation
        XCTAssertNotEqual(firstPosterData, seconfPosterData)
        XCTAssertEqual(indexLabel.label, "2/10")

    }
    
    func testNoButton() throws{
        sleep(3)
        let firstPoster = app.images["Poster"]
        app.buttons["Yes"].tap()
        sleep(3)
        let secondPoster = app.images["Poster"]
        
        let indexLabel = app.staticTexts["Index"]
        
        let firstPosterData = firstPoster.screenshot().pngRepresentation
        let seconfPosterData = secondPoster.screenshot().pngRepresentation
        XCTAssertNotEqual(firstPosterData, seconfPosterData)
        XCTAssertEqual(indexLabel.label, "2/10")
    }
    
    
    func testGameFinish() throws{
        sleep(2)
        for _ in 0..<10{
            app.buttons["Yes"].tap()
            sleep(2)
        }
        
        let alert = app.alerts["GameResultAlert"]
        
        XCTAssertTrue(alert.exists)
        XCTAssertEqual(alert.label, "Этот раунд окончен!")
        XCTAssertEqual(alert.buttons.firstMatch.label, "Сыграем еще раз")
    }
    
    func testAlertDismiss() throws{
        sleep(2)
        for _ in 0..<10{
            app.buttons["Yes"].tap()
            sleep(2)
        }
        
        let alert = app.alerts["GameResultAlert"]
        app.buttons.firstMatch.tap()
        
        sleep(2)
        
        let index = app.staticTexts["Index"]
        XCTAssertTrue(index.exists)
        XCTAssertEqual(index.label, "1/10")
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
