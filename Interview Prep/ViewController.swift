//
//  ViewController.swift
//  Interview Prep
//
//  Created by Karl Cridland on 08/06/2025.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    let questionsModel: QuestionsModel = QuestionsModel()
    
    let scroll: QuestionScrollView = QuestionScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview([self.scroll, self.questionsModel.view])
        self.questionsModel.onUpdate = {
            let buttons = self.scroll.setButtons(self.questionsModel.questions)
            buttons.forEach { button in
                button.onClicked = { question in
                    self.questionsModel.view.display(question)
                }
            }
        }
        self.questionsModel.get()
    }
    
    override func viewDidLayoutSubviews() {
        self.scroll.frame.origin.y = self.view.safeAreaInsets.top
        self.scroll.frame.size.height = self.view.frame.height - self.view.safeAreaInsets.top - self.view.safeAreaInsets.bottom
    }

}
