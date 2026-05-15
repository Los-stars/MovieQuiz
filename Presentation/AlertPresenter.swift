//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Amir on 13.05.2026.
//
import Foundation
import UIKit

final class AlertPresenter {
    func showAlert(model: AlertModel, from viewController: UIViewController) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completion()
        }
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
}
