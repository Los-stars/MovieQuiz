//
//  MovieQuizViewControllerMock.swift
//  MovieQuizViewControllerMock
//
//  Created by Amir on 18.06.2026.
//

//import Testing
//@testable import MovieQuiz
//import XCTest
//
//class MovieQuizViewControllerMock: MovieQuizViewControllerProtocol {
//    func show(quiz step: MovieQuiz.QuizStepViewModel) {
//        <#code#>
//    }
//    
//    func show(quiz result: MovieQuiz.QuizResultsViewModel) {
//        <#code#>
//    }
//    
//    func highlightImageBorder(isCorrectAnswer: Bool) {
//        <#code#>
//    }
//    
//    func showLoadingIndicator() {
//        <#code#>
//    }
//    
//    func hideLoadingIndicator() {
//        <#code#>
//    }
//    
//    func showNetworkError(message: String) {
//        <#code#>
//    }
//}
//
//final class MovieQuizPresenterTest: XCTestCase{
//    func testPresenterConvertModel() throws{
//        let viewControllerMock = MovieQuizViewControllerMock()
//        let sut = MovieQuizPresenter(viewController: viewControllerMock)
//        
//        let emptyData = Data()
//        let question = QuizQuestion(image: emptyData, text: "Quiz question", correctAnswer: true)
//        let viewModel = sut.convert(model: question)
//        
//        XCTAssertEqual(viewModel.image, emptyData)
//        XCTAssertEqual(viewModel.question, "Quiz question")
//        XCTAssertEqual(viewModel.questionNumber, "1/10")
//    }
//}
