//
//  StatusContainerView.swift
//  Interview Prep
//
//  Created by Karl Cridland on 09/06/2025.
//

import UIKit

class StatusContainerView: UIView {
    
    private let confidentView, unsureView, notConfidentView: StatusView
    
    init() {
        self.confidentView = StatusView(.confident)
        self.unsureView = StatusView(.unsure)
        self.notConfidentView = StatusView(.notConfident)
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerCurve = .continuous
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        var previous: StatusView?
        [self.confidentView, self.unsureView, self.notConfidentView].forEach { view in
            previous = self.set(view: view, previous: previous)
        }
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 220),
            self.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func set(view: StatusView, previous: StatusView?) -> StatusView {
        self.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3),
            view.leftAnchor.constraint(equalTo: previous?.rightAnchor ?? self.leftAnchor)
        ])
        return view
    }
    
    func update(_ confident: Int, _ unsure: Int, _ notConfident: Int) {
        self.confidentView.label.text = "\(confident)"
        self.unsureView.label.text = "\(unsure)"
        self.notConfidentView.label.text = "\(notConfident)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
