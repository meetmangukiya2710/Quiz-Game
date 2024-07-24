//
//  API.swift
//  Quiz Game
//
//  Created by R95 on 15/07/24.
//

import UIKit

// MARK: - Welcome
struct QuizModel: Decodable {
    let responseCode: Int?
    let results: [Result]?

    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
}

// MARK: - Result
struct Result: Decodable {
    let type: TypeEnum?
    let difficulty: Difficulty?
    let category: Category?
    let question, correctAnswer: String?
    let incorrectAnswers: [String]?

    enum CodingKeys: String, CodingKey {
        case type, difficulty, category, question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}

enum Category: String, Decodable {
    case celebrities = "Celebrities"
}

enum Difficulty: String, Decodable {
    case easy = "easy"
}

enum TypeEnum: String, Decodable {
    case multiple = "multiple"
}

class ApiClass {
    func apiFunc(completion: @escaping (QuizModel?) -> Void) {
        let link = URL(string: "https://opentdb.com/api.php?amount=10&category=26&difficulty=easy&type=multiple")
        var urlRequest = URLRequest(url: link!)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { data, respo, error in
            do {
                if error == nil {
                     let data = try JSONDecoder().decode(QuizModel.self, from: data!)
                    completion(data)
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
