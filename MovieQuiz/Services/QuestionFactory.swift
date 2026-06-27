import Foundation

class QuestionFactory: QuestionFactoryProtocol{
    
    private let moviesLoader: MoviesLoader
    weak var delegate: QuestionFactoryDelegate?
    private var movies : [MostPopularMovie] = []
    
    init(moviesLoader: MoviesLoader, delegate: QuestionFactoryDelegate?) {
        self.moviesLoader = moviesLoader
        self.delegate = delegate
    }
    
    func setup(delegate: QuestionFactoryDelegate){
        self.delegate = delegate
    }

    func requestNextQuestion() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            let index = (0..<movies.count).randomElement() ?? 0
            
            guard let movie = movies[safe: index] else { return }
            
            var imageData = Data()
            
            do{
                imageData = try Data(contentsOf: movie.resizedImageURL)
            }catch{
                print("Failed to load image")
            }
            
            let rating = Float(movie.rating) ?? 0
            
            let text = "Рейтинг этого фильма больше чем 7?"
            let correctAnswer = rating > 7
            
            let question = QuizQuestion(
                image: imageData,
                text: text,
                correctAnswer: correctAnswer)
            
            DispatchQueue.main.async{ [weak self] in
                guard let self = self else { return }
                delegate?.didReceiveNextQuestion(question: question)
            }
        }
    }
    
    func loadData(){
        moviesLoader.loadMovies(){ [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let mostPopularMovies):
                    self.movies = mostPopularMovies.items
                    self.delegate?.didLoadDataFromServer()
                case .failure(let error):
                    self.delegate?.didFailToLoadData(with: error)
                }
            }
        }
        print(movies)
    }
    
    //    private let quizQuestions : [QuizQuestion] = [
    //        QuizQuestion(image: "The Godfather", questionTitle: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
    //        QuizQuestion(image: "The Dark Knight", questionTitle: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
    //        QuizQuestion(image: "Kill Bill", questionTitle: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
    //        QuizQuestion(image: "The Avengers", questionTitle: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
    //        QuizQuestion(image: "Deadpool", questionTitle: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
    //        QuizQuestion(image: "The Green Knight", questionTitle: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
    //        QuizQuestion(image: "Old", questionTitle: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
    //        QuizQuestion(image: "The Ice Age Adventures of Buck Wild", questionTitle: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
    //        QuizQuestion(image: "Tesla", questionTitle: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
    //        QuizQuestion(image: "Vivarium", questionTitle: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
    //    ]
        
}
