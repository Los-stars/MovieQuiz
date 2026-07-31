//
//  MovieQuizViewControllerMock.swift
//  MovieQuizViewControllerMock
//
//  Created by Amir on 18.06.2026.
//

import Testing
@testable import MovieQuiz
import XCTest

class MovieQuizViewControllerMock: MovieQuizViewControllerProtocol {
    
    var showQuizStepCalled = false
    var showQuizResultCalled = false
    var highlightImageBordedCalled = false
    var showLoadingIndicatorCalled = false
    var hideLoadingIndicatorCalled = false
    var showNetworkErrorCalled = false
    
    var lastRecievedViewModel: QuizStepViewModel?
    var lastRecievedResultViewModel: QuizResultsViewModel?
    var lastReceivedIsCorrectAnswer: Bool?
    var lastReceivedErrorMessage: String?
    
    func show(quiz step: MovieQuiz.QuizStepViewModel) {
        showQuizStepCalled = true
        lastRecievedViewModel = step
    }
    
    func show(quiz result: MovieQuiz.QuizResultsViewModel) {
        showQuizResultCalled = true
        lastRecievedResultViewModel = result
    }
    
    func highlightImageBorder(isCorrectAnswer: Bool) {
        highlightImageBordedCalled = true
        lastReceivedIsCorrectAnswer = isCorrectAnswer
    }
    
    func showLoadingIndicator() {
        showLoadingIndicatorCalled = true
    }
    
    func hideLoadingIndicator() {
        hideLoadingIndicatorCalled = true
    }
    
    func showNetworkError(message: String) {
        showNetworkErrorCalled = true
        lastReceivedErrorMessage = message
    }
}

final class MovieQuizPresenterTest: XCTestCase{
    func testPresenterConvertModel() throws{
        let viewControllerMock = MovieQuizViewControllerMock()
        let sut = MovieQuizPresenter(viewController: viewControllerMock)
        
        let emptyData = Data()
        let question = QuizQuestion(image: emptyData, text: "Quiz question", correctAnswer: true)
        let viewModel = sut.convert(model: question)
        
        XCTAssertEqual(viewModel.image, emptyData)
        XCTAssertEqual(viewModel.question, "Quiz question")
        XCTAssertEqual(viewModel.questionNumber, "1/10")
    }
}
