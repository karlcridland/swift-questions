//
//  QuestionTableViewCell.swift
//  Interview Prep
//
//  Created by Karl Cridland on 08/06/2025.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    
    let questionLabel = UILabel()
    let answerPreviewLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupViews() {
        questionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        questionLabel.numberOfLines = 0
        
        answerPreviewLabel.font = UIFont.systemFont(ofSize: 14)
        answerPreviewLabel.textColor = .gray
        answerPreviewLabel.numberOfLines = 2

        contentView.addSubview(questionLabel)
        contentView.addSubview(answerPreviewLabel)

        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        answerPreviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),

            answerPreviewLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 4),
            answerPreviewLabel.leadingAnchor.constraint(equalTo: questionLabel.leadingAnchor),
            answerPreviewLabel.trailingAnchor.constraint(equalTo: questionLabel.trailingAnchor),
            answerPreviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(with question: Question) {
        questionLabel.text = question.question
        answerPreviewLabel.text = question.answer
    }
}
