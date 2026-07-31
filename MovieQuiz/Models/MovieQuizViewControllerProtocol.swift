//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by Amir on 18.06.2026.
//

protocol MovieQuizViewControllerProtocol: AnyObject{
    func show(quiz step: QuizStepViewModel)
    func show(quiz result: QuizResultsViewModel)
    
    func highlightImageBorder(isCorrectAnswer: Bool)
    
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func showNetworkError(message: String)
}
