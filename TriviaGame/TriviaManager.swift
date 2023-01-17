//
//  TriviaManager.swift
//  TriviaGame
//
//

import Foundation
import SwiftUI

class TriviaManager: ObservableObject {
    // Variables to set trivia and length of trivia
    private(set) var trivia: [Trivia.Result] = []
    @Published private(set) var length = 0
    
    // Variables to set question and answers
    @Published private(set) var index = 0
    @Published private(set) var question: AttributedString = ""
    @Published private(set) var answerChoices: [Answer] = []
    
    // Variables for score and progress
    @Published private(set) var score = 0
    @Published private(set) var progress: CGFloat = 0.00
    
    // Variables to know if an answer has been selected and reached the end of trivia
    @Published private(set) var answerSelected = false
    @Published private(set) var reachedEnd = false
    
    // Call the fetchTrivia function on intialize of the class, asynchronously
    init() {
        Task.init {
            await fetchTrivia()
        }
    }
    
    // Asynchronous HTTP request to get the trivia questions and answers
    func fetchTrivia() async {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10") else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }

            let decoder = JSONDecoder()
            // Line below allows us to convert the correct_answer key from the API into the correctAnswer in our Trivia model, without running into an error from the JSONDecoder that it couldn't find a matching codingKey
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(Trivia.self, from: data)

            DispatchQueue.main.async {
                // Reset variables before assigning new values, for when the user plays the game another time
                self.index = 0
                self.score = 0
                self.progress = 0.00
                self.reachedEnd = false

                // Set new values for all variables
                self.trivia = decodedData.results
                self.length = self.trivia.count
                self.setQuestion()
            }
        } catch {
            print("Error fetching trivia: \(error)")
        }
    }
    
    // Function to go to next question. If reached end of the trivia, set reachedEnd to true
    func goToNextQuestion() {
        // If didn't reach end of array, increment index and set next question
        if index + 1 < length {
            index += 1
            setQuestion()
        } else {
            // If reached end of array, set reachedEnd to true
            reachedEnd = true
        }
    }
    
    // Function to set a new question and answer choices, and update the progress
    func setQuestion() {
        answerSelected = false
        progress = CGFloat(Double((index + 1)) / Double(length) * 350)

        // Only setting next question if index is smaller than the trivia's length
        if index < length {
            let currentTriviaQuestion = trivia[index]
            question = currentTriviaQuestion.formattedQuestion
            answerChoices = currentTriviaQuestion.answers
        }
    }
    
    // Function to know that user selected an answer, and update the score
    func selectAnswer(answer: Answer) {
        answerSelected = true
        
        // If answer is correct, increment score
        if answer.isCorrect {
            score += 1
        }
    }
}

