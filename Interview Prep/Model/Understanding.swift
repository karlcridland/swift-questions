//
//  Understanding.swift
//  Interview Prep
//
//  Created by Karl Cridland on 08/06/2025.
//

import UIKit

enum Understanding: String, Codable, CaseIterable {
    case confident = "Confident"
    case unsure = "Unsure"
    case notConfident = "Not Confident"
    
    var color: UIColor? {
        switch(self) {
            case .confident:
            return .trafficLightGreen
        case .unsure:
            return .trafficLightAmber
        case .notConfident:
            return .trafficLightRed
        }
    }
    
    var sort: Int {
        switch(self) {
            case .confident:
            return 1
        case .unsure:
            return 2
        case .notConfident:
            return 3
        }
    }
    
    func image(_ fill: Bool = false) -> UIImage? {
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        let fillString = fill ? ".fill" : ""
        switch (self) {
        case .confident:
            return UIImage(systemName: "hand.thumbsup\(fillString)", withConfiguration: config)
        case .unsure:
            return UIImage(systemName: "hand.pinch\(fillString)", withConfiguration: config)
        case .notConfident:
            return UIImage(systemName: "hand.thumbsdown\(fillString)", withConfiguration: config)
        }
    }
    
}
