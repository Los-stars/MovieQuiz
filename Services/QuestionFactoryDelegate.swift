//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Amir on 11.05.2026.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject{
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer()
    func didFailToLoadData(with error: Error)
}
