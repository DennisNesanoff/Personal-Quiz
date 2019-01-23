//
//  Question.swift
//  Personal Quiz
//
//  Created by Dennis Nesanoff on 20/01/2019.
//  Copyright © 2019 Dennis Nesanoff. All rights reserved.
//

struct Question {
    var text: String
    var typeOfAnswers: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var typeOfAnimal: AnimalType
}

enum AnimalType: Character {
    case parrot = "🦜", elefant = "🐘", lion = "🦁", horse = "🐎"
    
    var definition: String {
        switch self {
        case .parrot:
            return "Попугай относится к классу птицы, отряду попугаеобразные, семейству попугаевые (лат. Psittacidae)."
        case .elefant:
            return "Слон — самое большое наземное животное класса млекопитающие, типа хордовые, отряда хоботные, семейства слоновые (лат. Elephantidae)."
        case .lion:
            return "Лев (лат. Panthera leo) — вид хищных млекопитающих, один из четырёх представителей рода пантер (Panthera), относящегося к подсемейству больших кошек (Pantherinae) в составе семейства кошачьих (Felidae). Наряду с тигром — самая крупная из ныне живущих кошек, масса некоторых самцов может достигать 250 кг."
        case .horse:
            return "Лошади (Equus) в широком смысле слова — единственный ныне живущий род семейства лошадиных, или непарнокопытных (Equidae s. Solidungula), отряда непарнокопытных (Perissodactyla)."
        }
    }
}
