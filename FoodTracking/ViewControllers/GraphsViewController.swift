//
//  GraphsViewController.swift
//  FoodTracking
//
//  Created by Елена Червоткина on 11.09.2020.
//  Copyright © 2020 noname. All rights reserved.
//

import UIKit

class GraphsViewController: UIViewController {
    
    @IBOutlet weak var circularProgress: CircularProgressView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var scoreMoreLabel: UILabel!
    
    var user: User!
    var foods: [Food]!
    let date = Date().stripTime()
    
    // используем этот метод, чтобы обновлять данные при каждом переключении между экранами
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let score = user.getTotalScore(date: date)
        changeView(day: score)
    }
}

extension GraphsViewController {
    private func changeView(day score: Int) {
        
        switch score {
        case 0:
            getCaseDescription(color: #colorLiteral(red: 0.9764705896, green: 0.9467297923, blue: 0, alpha: 1),
                               user: score,
                               background: #colorLiteral(red: 0.6803390694, green: 0.8305631209, blue: 0.9764705896, alpha: 1),
                               description: "Ноль лучше минуса ❤️")
        case 0..<Int(Double(Food.maxScores()) * 0.38):
            getCaseDescription(color: #colorLiteral(red: 0.9764705896, green: 0.9467297923, blue: 0, alpha: 1),
                               user: score,
                               background: #colorLiteral(red: 0.6803390694, green: 0.8305631209, blue: 0.9764705896, alpha: 1),
                               description: "Отличное начало! 👏🏻")
        case Int(Double(Food.maxScores()) * 0.38)..<Int(Double(Food.maxScores()) * 0.8):
            getCaseDescription(color: #colorLiteral(red: 0.6808604821, green: 0.9510826459, blue: 0, alpha: 1),
                               user: score,
                               background: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),
                               description: "Ты почти у цели 🔥")
        case Int(Double(Food.maxScores()) * 0.8):
            getCaseDescription(color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),
                               user: score,
                               background: #colorLiteral(red: 0.7009666562, green: 0.5654001832, blue: 0.9669840932, alpha: 1),
                               description: "Ты достиг дневной цели 🤟🏻")
        case Int(Double(Food.maxScores()) * 0.81)..<Food.maxScores():
            getCaseDescription(color: #colorLiteral(red: 0.3712404636, green: 0.6928537436, blue: 0.2868239483, alpha: 1),
                                user: score,
                                background: #colorLiteral(red: 0.7009666562, green: 0.5654001832, blue: 0.9669840932, alpha: 1),
                                description: "Так держать 😉")
        case Food.maxScores():
            getCaseDescription(color: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1),
                                user: score,
                                background: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1),
                                description: "Продолжай в том же духе 🥳")
        default:
            getCaseDescription(color: #colorLiteral(red: 0.9730492234, green: 0.149497062, blue: 0.02618659474, alpha: 1),
                                user: score,
                                background: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                                description: "Главное начать")
        }
    }
    
    private func getCaseDescription(color progress: UIColor,
                                    user value: Int,
                                    background color: UIColor,
                                    description text: String) {
        circularProgress.trackClr = UIColor.black
        circularProgress.progressClr = progress
        view.backgroundColor = color
        descriptionLabel.text = text
        scoreMoreLabel.text = String(value)
        
        if value >= 0 {
            circularProgress.setProgressWithAnimation(duration: 1.5,
                                                      value: (Float(1.0)/Float(Food.maxScores()))*Float(value))
            valueLabel.text = "Ещё можно набрать \(Food.maxScores() - user.getTotalPositiveScore(date: date)) баллов"
            scoreMoreLabel.textColor = .black
        } else {
            circularProgress.setProgressWithAnimation(duration: 3.0,
                                                      value: (Float(1.0)/Float(Food.minScores()))*Float(value))
            valueLabel.text = "Ты можешь побороть свои страсти"
            scoreMoreLabel.text = String(value)
            scoreMoreLabel.textColor = .red
        }
    }
}
