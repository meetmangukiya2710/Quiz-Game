//
//  QuizPageVC.swift
//  Quiz Game
//
//  Created by R95 on 15/07/24.
//

import UIKit

class QuizPageVC: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var quwstionNo: UILabel!
    
    
    var apiClass = ApiClass()
    var quizQuestions: [Result] = []
    var currentQuestionIndex = 0
    let activityView = UIActivityIndicatorView(style: .gray)
    var correctCount = 0
    var inCorrectCount = 0
    var totalMark = 0
    var questionNo = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.setTitle("Start Quiz", for: .normal)
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        isEnabledFunc(ans: true)
        if sender.currentTitle == "Start Quiz" {
            fetchQuizData()
        } else {
            showNextQuestion()
            totalMark = quizQuestions.count
            questionNoCount()
        }
    }
    
    func questionNoCount() {
        if questionNo < totalMark + 1 {
            quwstionNo.text = "\(questionNo)"
            questionNo += 1
        }
    }
    
    func fetchQuizData() {
        apiClass.apiFunc() { [weak self] quizData in
            DispatchQueue.main.async {
                if let quizData = quizData {
                    self?.quizQuestions = quizData.results ?? []
                    self?.startQuiz()
                } else {
                    print("Failed to fetch quiz data.")
                }
            }
        }
    }
    
    func startQuiz() {
        nextButton.setTitle("Next", for: .normal)
        nextButton.isEnabled = true
        showNextQuestion()
    }
    
    func showNextQuestion() {
        guard currentQuestionIndex < quizQuestions.count else {
            finishQuiz()
            return
        }
        
        let question = quizQuestions[currentQuestionIndex]
        questionLabel.text = question.question
        updateAnswerButtons(for: question)
        
        currentQuestionIndex += 1
        nextButton.isEnabled = false
    }
    
    func updateAnswerButtons(for question: Result) {
        guard let incorrectAnswers = question.incorrectAnswers, let correctAnswer = question.correctAnswer else {
            return
        }
        
        var answers = incorrectAnswers
        answers.append(correctAnswer)
        answers.shuffle()
        answers.shuffle()
        
        for (index, button) in answerButtons.enumerated() {
            button.setTitle(answers[index], for: .normal)
        }
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        let selectedAnswer = sender.currentTitle ?? ""
        let correctAnswer = quizQuestions[currentQuestionIndex - 1].correctAnswer ?? ""
        
        if selectedAnswer == correctAnswer {
            NSLog("Correct! 👍")
            correctCount += 1
            isEnabledFunc(ans: false)
        } else {
            NSLog("Incorrect! 👎")
            inCorrectCount += 1
            isEnabledFunc(ans: false)
        }
        
        nextButton.isEnabled = true
    }
    
    func finishQuiz() {
        questionLabel.text = "Quiz Complete"
        nextButton.setTitle("Submit", for: .normal)
        nextButton.isHidden = true
        showActivityIndicatory()
        activityView.startAnimating()
        isEnabledFunc(ans: false)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [self] in
            activityView.stopAnimating()
            activityView.hidesWhenStopped = true
            navigation()
        }
    }
    
    func navigation() {
        let naviagtion = storyboard?.instantiateViewController(identifier: "ResultPageVC") as! ResultPageVC
        naviagtion.totalCorrect = correctCount
        naviagtion.totalInCorrect = inCorrectCount
        naviagtion.totalMark = totalMark
        navigationController?.pushViewController(naviagtion, animated: true)
    }
    
    func showActivityIndicatory() {
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }
    
    func isEnabledFunc(ans: Bool) {
        for i in answerButtons {
            i.isEnabled = ans
        }
    }
}
