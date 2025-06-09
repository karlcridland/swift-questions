//
//  QuestionInformationView.swift
//  Interview Prep
//
//  Created by Karl Cridland on 09/06/2025.
//

import UIKit

class QuestionInformationView: UIView {
    
    let category, title, answer: UILabel
    let understanding: QuestionInformationButtons
    let copyTitle, openBrowser: UIButton
    let background: UIView
    
    init() {
        self.category = UILabel()
        self.title = UILabel()
        self.answer = UILabel()
        self.understanding = QuestionInformationButtons()
        self.copyTitle = UIButton()
        self.openBrowser = UIButton()
        self.background = UIView()
        
        super.init(frame: .zero)
        
        self.background.backgroundColor = .white
        self.background.layer.cornerRadius = 24
        self.background.layer.cornerCurve = .continuous
        self.shadow()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.category.font = .systemFont(ofSize: 14, weight: .bold)
        self.category.numberOfLines = 1
        
        self.title.font = .systemFont(ofSize: 18, weight: .bold)
        self.title.numberOfLines = 0
        
        self.answer.font = .systemFont(ofSize: 16, weight: .regular)
        self.answer.numberOfLines = 0
        
        self.copyTitle.addTarget(self, action: #selector(self.copyQuestionToClipBoard), for: .touchUpInside)
        self.openBrowser.addTarget(self, action: #selector(self.openQuestionOnBrowser), for: .touchUpInside)
        
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        [self.copyTitle: "rectangle.portrait.on.rectangle.portrait", self.openBrowser: "safari"].forEach { (button, systemName) in
            let image = UIImage(systemName: systemName, withConfiguration: config)
            self.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.imageView?.contentMode = .center
            button.setImage(image, for: .normal)
            button.tintColor = .systemBlue
        }
        
        self.addSubview([self.background])
        self.background.translatesAutoresizingMaskIntoConstraints = false
        
        var previous: UIView?
        [self.category, self.title, self.answer, self.understanding].forEach { view in
            previous = self.place(view: view, previous: previous)
        }
        
    }
    
    @objc func copyQuestionToClipBoard() {
        UIPasteboard.general.string = self.title.text
    }
    
    @objc func openQuestionOnBrowser() {
        let encodedQuery = self.title.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: "https://www.google.com/search?q=\(encodedQuery)") {
            UIApplication.shared.open(url)
        }
    }
    
    func set(question: Question) {
        self.title.text = question.question
        self.category.text = "\(question.category) - \(question.difficulty.toString)"
        self.category.textColor = question.difficulty.color
        self.answer.text = question.answer
    }
    
    func place(view: UIView, previous: UIView?) -> UIView {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let topAnchor: NSLayoutYAxisAnchor = previous?.bottomAnchor ?? copyTitle.bottomAnchor
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: previous == nil || previous == self.title ? 20 : 5),
            view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            view.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)
        ])
        return view
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.copyTitle.topAnchor, constant: -20),
            self.bottomAnchor.constraint(equalTo: self.understanding.bottomAnchor, constant: 10),
            self.understanding.heightAnchor.constraint(equalToConstant: 100),
            
            self.copyTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            self.copyTitle.bottomAnchor.constraint(equalTo: self.background.topAnchor, constant: -10),
            self.copyTitle.widthAnchor.constraint(equalToConstant: 40),
            self.copyTitle.heightAnchor.constraint(equalToConstant: 40),
            
            self.openBrowser.rightAnchor.constraint(equalTo: self.copyTitle.leftAnchor, constant: -10),
            self.openBrowser.bottomAnchor.constraint(equalTo: self.background.topAnchor, constant: -10),
            self.openBrowser.widthAnchor.constraint(equalToConstant: 40),
            self.openBrowser.heightAnchor.constraint(equalToConstant: 40),
            
            self.background.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.background.topAnchor.constraint(equalTo: self.category.topAnchor, constant: -20),
            self.background.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.background.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
