//
//  QuestionViewController.swift
//  Personal Quiz
//
//  Created by Dennis Nesanoff on 20/01/2019.
//  Copyright © 2019 Dennis Nesanoff. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    // MARK: - @IBOutlets
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleButton: [UIButton]!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet var multipleLables: [UILabel]!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet var rangedLabel: [UILabel]!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet var progressView: UIProgressView!
    
    var questions: [Question] = [
        Question(text: "Какую еду предпочитаете?", typeOfAnswers: .single, answers: [
            Answer(text: "Каша", typeOfAnimal: .parrot),
            Answer(text: "Фрукты", typeOfAnimal: .elefant),
            Answer(text: "Мясо", typeOfAnimal: .lion),
            Answer(text: "Зелень", typeOfAnimal: .horse)
            ]),
        Question(text: "Какие виды деятельности Вы любите?", typeOfAnswers: .multiple, answers: [
            Answer(text: "Плавать", typeOfAnimal: .elefant),
            Answer(text: "Петь", typeOfAnimal: .parrot),
            Answer(text: "Охотиться", typeOfAnimal: .lion),
            Answer(text: "Бегать", typeOfAnimal: .horse)
            ]),
        Question(text: "Как вы относитесь к поездке?", typeOfAnswers: .ranged, answers: [
            Answer(text: "Ненавижу", typeOfAnimal: .lion),
            Answer(text: "Они меня нервируют", typeOfAnimal: .elefant),
            Answer(text: "Не замечаю", typeOfAnimal: .parrot),
            Answer(text: "Обожаю", typeOfAnimal: .horse)
            ])
    ]
    
    var questionIndex = 0
    
    var answersChosen = [Answer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        navigationItem.title = "Question №\(questionIndex + 1)"
        let question = questions[questionIndex]
        questionLabel.text = question.text
        
        let answers = question.answers
        let progress = Float(questionIndex) / Float(questions.count)
        progressView.progress = progress
        
        switch question.typeOfAnswers {
        case .single:
            updateSingleStack(using: answers)
        case .multiple:
            updateMultipleStack(using: answers)
        case .ranged:
            updateRangedStack(using: answers)
        }
    }

    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton.forEach { $0.isHidden = true }
        for index in 0..<min(singleButton.count, answers.count) {
            singleButton[index].isHidden = false
            singleButton[index].setTitle(answers[index].text, for: .normal)
        }
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multipleLables.forEach { $0.superview!.isHidden = true }
        for index in 0..<min(multipleLables.count, answers.count) {
            multipleLables[index].superview!.isHidden = false
            multipleLables[index].text = answers[index].text
        }
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedLabel.first!.text = answers.first!.text
        rangedLabel.last!.text = answers.last!.text
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultSegue", sender: nil)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.answers = answersChosen
        }
    }

    // MARK: - @IBAction
    @IBAction func singleButtonPressed(_ sender: UIButton) {
        let answers = questions[questionIndex].answers
        let index = singleButton.index(of: sender)!
        answersChosen.append(answers[index])
        
        nextQuestion()
    }
    
    @IBAction func multipleButtonPressed() {
        let answers = questions[questionIndex].answers
        for index in 0..<min(multipleLables.count, answers.count) {
            let label = multipleLables[index]
            let stackView = label.superview!
            let multiSwitch = stackView.subviews.last! as! UISwitch
            
            if multiSwitch.isOn {
                answersChosen.append(answers[index])
            }
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedButtonPressed() {
        let answers = questions[questionIndex].answers
        let index = Int(round(slider.value / Float(answers.count + 1)))
        answersChosen.append(answers[index])
        
        nextQuestion()
    }
}
