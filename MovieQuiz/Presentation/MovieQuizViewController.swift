import UIKit



final class MovieQuizViewController: UIViewController, MovieQuizViewControllerProtocol{
    
    // MARK: - Lifecycle
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var questionTitleLabel: UILabel!
    @IBOutlet private weak var indexLabel: UILabel!
    @IBOutlet private weak var previewImage: UIImageView!
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var yesButton: UIButton!
    @IBOutlet private weak var noButton: UIButton!
//    private var buttonIsEnabled = true
//    private var correctAnswers = 0
//    
//    private var questionFactory: QuestionFactoryProtocol?
//    private var currentQuestion: QuizQuestion?
//    
//    private var statisticService: StatisticServiceProtocol?
//    
//    private let alertPresenter = AlertPresenter()
//    
//    private var presenter: MovieQuizPresenter!
        
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MovieQuizPresenter(viewController: self)

        previewImage.layer.cornerRadius = 20
        statisticService = StatisticService()

        showLoadingIndicator()
    }

    // MARK: - Actions

//    @IBAction private func yesButtonClicked(_ sender: UIButton) {
//        presenter.yesButtonClicked()
//    }
//
//    @IBAction private func noButtonClicked(_ sender: UIButton) {
//        presenter.noButtonClicked()
//    }
//
//    // MARK: - Private functions
//
//    func show(quiz step: QuizStepViewModel) {
//        previewImage.layer.borderColor = UIColor.clear.cgColor
//        previewImage.image = UIImage(data: step.image) ?? UIImage()
//        questionLabel.text = step.question
//        indexLabel.text = step.questionNumber
//    }
//
//    func show(quiz result: QuizResultsViewModel) {
//        let alert = UIAlertController(
//            title: result.title,
//            message: result.text,
//            preferredStyle: .alert)
//        
//        let action = UIAlertAction(title: result.buttonText, style: .default) { [weak self] _ in
//            guard let self = self else { return }
//            
//            self.presenter.restartGame()
//        }
//        
//        alert.addAction(action)
//        
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    func highlightImageBorder(isCorrectAnswer: Bool) {
//        previewImage.layer.masksToBounds = true
//        previewImage.layer.borderWidth = 8
//        previewImage.layer.borderColor = isCorrectAnswer ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
//    }
//    
//    func showLoadingIndicator() {
//        activityIndicator.isHidden = false
//        activityIndicator.startAnimating()
//    }
//    
//    func hideLoadingIndicator(){
//        activityIndicator.isHidden = true
//    }
//    
//    func showNetworkError(message: String) {
//        activityIndicator.isHidden = true // скрываем индикатор загрузки
//
//        let alert = UIAlertController(
//            title: "Ошибка",
//            message: message,
//            preferredStyle: .alert)
//
//        let action = UIAlertAction(title: "Попробовать еще раз",
//                                   style: .default) { [weak self] _ in
//            guard let self = self else { return }
//
//            presenter.resetQuestionIndex()
//            presenter.restartGame()
//        }
//
//        alert.addAction(action)
//    }
//}

/*
 Mock-данные
 
 
 Картинка: The Godfather
 Настоящий рейтинг: 9,2
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Dark Knight
 Настоящий рейтинг: 9
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Kill Bill
 Настоящий рейтинг: 8,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Avengers
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Deadpool
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Green Knight
 Настоящий рейтинг: 6,6
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Old
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: The Ice Age Adventures of Buck Wild
 Настоящий рейтинг: 4,3
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Tesla
 Настоящий рейтинг: 5,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Vivarium
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
*/
