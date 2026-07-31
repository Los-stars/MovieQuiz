//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Amir on 13.05.2026.
//
import Foundation

struct AlertModel{
    let title: String
    let message: String
    let buttonText: String
    let completion: () -> Void
}
