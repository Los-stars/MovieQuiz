import Foundation

class QuestionFactory: QuestionFactoryProtocol{
    
    weak var delegate: QuestionFactoryDelegate?
    
    func setup(delegate: QuestionFactoryDelegate){
        self.delegate = delegate
    }
    private let quizQuestions : [QuizQuestion] = [
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
    
    func requestNextQuestion() {
        guard let index = (0..<quizQuestions.count).randomElement() else {
            delegate?.didReceiveNextQuestion(question: nil)
            return
        }

        let question = quizQuestions[safe: index]
        delegate?.didReceiveNextQuestion(question: question)
    }
}
