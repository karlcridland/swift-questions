//
//  Status.swift
//  Interview Prep
//
//  Created by Karl Cridland on 09/06/2025.
//

class Status {
    
    let view = StatusContainerView()
    
    init() {
        
    }
    
    func update(_ questions: [Question]) {
        let confidentCount: Int = questions.filter({$0.understanding == .confident}).count
        let unsureCount: Int = questions.filter({$0.understanding == .unsure}).count
        let notConfidentCount: Int = questions.filter({$0.understanding == .notConfident}).count
        self.view.update(confidentCount, unsureCount, notConfidentCount)
    }
    
}
