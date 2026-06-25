import UIKit



final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate{
    
    // MARK: - Lifecycle
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var questionTitleLabel: UILabel!
    @IBOutlet private weak var indexLabel: UILabel!
    @IBOutlet private weak var previewImage: UIImageView!
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var yesButton: UIButton!
    @IBOutlet private weak var noButton: UIButton!
    private var currentQuestionIndex = 0
    private var buttonIsEnabled = true
    private var correctAnswers = 0
    
    private let questionsAmount: Int = 10
    private var questionFactory: QuestionFactoryProtocol?
    private var currentQuestion: QuizQuestion?
    
    private var staticticService: StatisticServiceProtocol?
    
    private let alertPresenter = AlertPresenter()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImage()
        
        previewImage.layer.cornerRadius = 20
        questionFactory = QuestionFactory(moviesLoader: MoviesLoader(), delegate: self)
        staticticService = StatisticService()
        
        showLoadingIndicator()
        questionFactory?.loadData()
    }
    private func showNetworkError(message: String) {
//        hideLoadingIndicator()
        
        // создайте и покажите алерт
        let alertModel = AlertModel(title: "Ошибка", message: message, buttonText: "Попробовать ещё раз"){ [weak self] in
            guard let self = self else { return }
            
            currentQuestionIndex = 0
            correctAnswers = 0
            
            questionFactory?.requestNextQuestion()
            
            buttonIsEnabled = true
            yesButton.isEnabled = buttonIsEnabled ?? true
            noButton.isEnabled = buttonIsEnabled ?? true
        }
        alertPresenter.showAlert(model: alertModel, from: self)
    }
    
    private func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    // MARK: - QuestionFactoryDelegate

    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }

        currentQuestion = question
        let viewModel = convert(model: question)
        
        DispatchQueue.main.async { [weak self] in
            self?.show(quiz: viewModel)
        }
    }
    
    func didLoadDataFromServer() {
        activityIndicator.isHidden = true
        questionFactory?.requestNextQuestion()
    }
    
    func didFailToLoadData(with error: any Error) {
        showNetworkError(message: error.localizedDescription)
    }
    
    private func setupImage(){
        previewImage.layer.cornerRadius = 20
    }
        
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        guard let currentQuestion = currentQuestion else{
            return
        }
        showAnswerResult(isCorrect: currentQuestion.correctAnswer)
    }
        
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        guard let currentQuestion = currentQuestion else{
            return
        }
        showAnswerResult(isCorrect: !currentQuestion.correctAnswer)
    }
        
    private func showAnswerResult(isCorrect: Bool) {
        if isCorrect{
            addLayer(image: previewImage, color: .ypGreen)
            correctAnswers += 1
        }else{
            addLayer(image: previewImage, color: .ypRed)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.showNextQuestionOrResults()
        }
        
        buttonIsEnabled = false
        yesButton.isEnabled = buttonIsEnabled
        noButton.isEnabled = buttonIsEnabled
    }
        
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let newModel = QuizStepViewModel(image: UIImage(data: model.image) ?? UIImage(), question: model.text, questionNumber: "\(currentQuestionIndex+1)/\(questionsAmount)")

        return newModel
    }
        
    private func show(quiz step: QuizStepViewModel) {
        clearLayer(image: previewImage)
        previewImage.image = step.image
        indexLabel.text = step.questionNumber
        questionLabel.text = step.question
    }
        
    private func show(quiz result: QuizResultsViewModel) {
        let alertModel = AlertModel(
            title: result.title,
            message: result.text,
            buttonText: result.buttonText) { [weak self] in
                self?.currentQuestionIndex = 0
                self?.correctAnswers = 0
                self?.questionFactory?.requestNextQuestion()
                self?.buttonIsEnabled = true
                self?.yesButton.isEnabled = self?.buttonIsEnabled ?? true
                self?.noButton.isEnabled = self?.buttonIsEnabled ?? true
            }
        alertPresenter.showAlert(model: alertModel, from: self)
    }
        
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questionsAmount-1{ // 1
            guard let statisticService = staticticService else{
                return
            }
            statisticService.store(correct: correctAnswers, total: questionsAmount)
            let model = QuizResultsViewModel(title: "Этот раунд окончен!", text: "Ваш результат: \(correctAnswers)/\(questionsAmount)\nКоличество сыграных квизов: \(statisticService.gamesCount)\nРекорд: \(statisticService.bestGame.correct)/\(statisticService.bestGame.total) (\(statisticService.bestGame.date.dateTimeString))\nСредняя точность: \(String(format: "%.2f", statisticService.totalAccuracy))%", buttonText: "Сыграем еще раз")
            show(quiz: model)
        }else {
            currentQuestionIndex += 1
            questionFactory?.requestNextQuestion()
        }
        buttonIsEnabled = true
        yesButton.isEnabled = buttonIsEnabled
        noButton.isEnabled = buttonIsEnabled
            
    }
        
    private func clearLayer(image: UIImageView) {
        image.layer.borderWidth = 0
        image.layer.borderColor = nil
    }
        
    private func addLayer(image: UIImageView, color: UIColor){
        image.layer.borderWidth = 8
        image.layer.borderColor = color.cgColor
        image.layer.cornerRadius = 20
    }
}
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
