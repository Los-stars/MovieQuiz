//
//  MovieQuizUITests.swift
//  MovieQuizUITests
//
//  Created by Amir on 07.06.2026.
//

import XCTest

protocol Screen {
    var app: XCUIApplication { get }
}

class MainScreen: Screen{
    var app: XCUIApplication
    
    private enum Identifiers{
        static let poster = "Poster"
        static let yes = "Yes"
        static let no = "No"
        static let index = "Index"
        static let alert = "GameResultAlert"
    }
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    func getPosterImage() -> Data?{
        return app.images[Identifiers.poster].screenshot().pngRepresentation
    }
    
    func tapButton(which button: String) -> Self{
        sleep(5)
        let Button = app.buttons[button]
        let exists = Button.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "Button '\(Button)' not found")
        Button.tap()
        return self
    }
    
    func verifyIndex(expectedIndex: String) -> Self{
        sleep(5)
        let index = app.staticTexts[Identifiers.index]
        XCTAssertTrue(index.waitForExistence(timeout: 5))
        XCTAssertEqual(index.label, expectedIndex)
        return self
    }
    
    func verifyPosterChanged(from oldIMage: Data?) -> Self{
        let newImage = app.images[Identifiers.poster].screenshot().pngRepresentation
        XCTAssertTrue(oldIMage != newImage)
        return self
    }
    
    func skipTenQuestions() -> Self{
        let yesButton = app.buttons[Identifiers.yes]
        XCTAssertTrue(yesButton.waitForExistence(timeout: 5))
        
        for _ in 0..<11{
            yesButton.tap()
            sleep(10)
        }
        return self
    }
    
    func checkAlertText(labelText: String, buttonText: String) -> Self{
        let alert = app.alerts[Identifiers.alert]
        
        XCTAssertTrue(alert.exists)
        XCTAssertEqual(alert.label, labelText)
        XCTAssertEqual(alert.buttons.firstMatch.label, buttonText)
        
        return self
    }
    
    func checkAlertDismiss(indexLabel: String) -> Self{
        let alert = app.alerts[Identifiers.alert]
        XCTAssertTrue(alert.waitForExistence(timeout: 5))
        let alertButton = alert.buttons.firstMatch
        alertButton.tap()
        
        sleep(5)
        
        let index = app.staticTexts[Identifiers.index]
        XCTAssertTrue(index.exists)
        XCTAssertEqual(index.label, indexLabel)
        
        return self
    }
    
}

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
        let mainScreen = MainScreen(app: app)
        
        let initialPosterData = mainScreen.getPosterImage()
        
        mainScreen
            .tapButton(which: "Yes")
            .verifyIndex(expectedIndex: "2/10")
            .verifyPosterChanged(from: initialPosterData)
    }
    
    func testNoButton() throws{
        let mainScreen = MainScreen(app: app)
        
        let initialPosterData = mainScreen.getPosterImage()
        
        mainScreen
            .tapButton(which: "No")
            .verifyIndex(expectedIndex: "2/10")
            .verifyPosterChanged(from: initialPosterData)
    }
    
    
    func testGameFinish() throws{
        let mainScreen = MainScreen(app: app)
        
        mainScreen
            .skipTenQuestions()
            .checkAlertText(labelText: "Этот раунд окончен!", buttonText: "Сыграть ещё раз")
    }
    
    func testAlertDismiss() throws{
        let mainScreen = MainScreen(app: app)
        
        mainScreen
            .skipTenQuestions()
            .checkAlertDismiss(indexLabel: "1/10")
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
