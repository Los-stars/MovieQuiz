import UIKit

// К сожалению, customFont у меня не подключился. Я обращался за помощью, но мне сказали, что в проекте всё нормально. Однако у меня он всё равно не работает. Поэтому я просто поменял customFont на system прошу не судить строго.

struct QuizQuestion{
    let image: String
    let questionTitle: String
    let correctAnswer: Bool
}

struct QuizStepViewModel {
  let image: UIImage
  let question: String
  let questionNumber: String
}

struct QuizResultsViewModel {
  let title: String
  let text: String
  let buttonText: String
}

final class MovieQuizViewController: UIViewController {
    // MARK: - Lifecycle
    @IBOutlet private weak var questionTitleLabel: UILabel!
    @IBOutlet private weak var indexLabel: UILabel!
    @IBOutlet private weak var previewImage: UIImageView!
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var yesButton: UIButton!
    @IBOutlet private weak var noButton: UIButton!
    private var quizQuestions = [QuizQuestion]()
    private var currentQuestionIndex = 0
    private var correntAnswers = 0
    private var currentQuestionAnswer = false
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareMockData()
        quizQuestions.shuffle()
        let currentQuestion = quizQuestions[currentQuestionIndex]
        let convertedQuestion = convert(model: currentQuestion)
        currentQuestionAnswer = currentQuestion.correctAnswer
        show(quiz: convertedQuestion)
    }
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        showAnswerResult(isCorrect: currentQuestionAnswer)
    }
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        showAnswerResult(isCorrect: !currentQuestionAnswer)
    }
    
    private func showAnswerResult(isCorrect: Bool) {
        if isCorrect{
            addLayer(image: previewImage, color: .ypGreen)
            correntAnswers += 1
        }else{
            addLayer(image: previewImage, color: .ypRed)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
           self.showNextQuestionOrResults()
        }
    }
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let newModel = QuizStepViewModel(image: UIImage(named: model.image) ?? UIImage(), question: model.questionTitle, questionNumber: "\(currentQuestionIndex+1)/10")
        return newModel
    }
    
    private func show(quiz step: QuizStepViewModel) {
        clearLayer(image: previewImage)
        previewImage.image = step.image
        indexLabel.text = step.questionNumber
        questionLabel.text = step.question
    }
    
    private func show(quiz result: QuizResultsViewModel) {
        let alert = UIAlertController(title: result.title, message: result.text, preferredStyle: .alert)
        let action = UIAlertAction(title: result.buttonText, style: .default) { _ in
            self.currentQuestionIndex = 0
            self.correntAnswers = 0
            let firstQuestion = self.quizQuestions[self.currentQuestionIndex]
            let viewModel = self.convert(model: firstQuestion)
            self.show(quiz: viewModel)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showNextQuestionOrResults() {
        print(currentQuestionIndex, quizQuestions.count)
      if currentQuestionIndex == quizQuestions.count - 1{ // 1
          let model = QuizResultsViewModel(title: "Этот раунд окончен!", text: "Ваш результат: \(self.correntAnswers)/10", buttonText: "Сыграем еще раз")
          show(quiz: model)
      } else {
          currentQuestionIndex += 1
          let nextQuestion = quizQuestions[currentQuestionIndex]
          currentQuestionAnswer = nextQuestion.correctAnswer
          let viewModel = convert(model: nextQuestion)
                  
          show(quiz: viewModel)
      }
    }
    
    private func clearLayer(image: UIImageView) {
        image.layer.masksToBounds = false
        image.layer.borderWidth = 0
        image.layer.borderColor = nil
        image.layer.cornerRadius = 0
    }
    
    private func addLayer(image: UIImageView, color: UIColor){
        image.layer.masksToBounds = true
        image.layer.borderWidth = 8
        image.layer.borderColor = color.cgColor
        image.layer.cornerRadius = 20
    }
    
    private func prepareMockData(){
        quizQuestions = [
            QuizQuestion(image: "The Godfather", questionTitle: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
            QuizQuestion(image: "The Dark Knight", questionTitle: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
            QuizQuestion(image: "Kill Bill", questionTitle: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
            QuizQuestion(image: "The Avengers", questionTitle: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
            QuizQuestion(image: "Deadpool", questionTitle: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
            QuizQuestion(image: "The Green Knight", questionTitle: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
            QuizQuestion(image: "Old", questionTitle: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
            QuizQuestion(image: "The Ice Age Adventures of Buck Wild", questionTitle: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
            QuizQuestion(image: "Tesla", questionTitle: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
            QuizQuestion(image: "Vivarium", questionTitle: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
        ]
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
