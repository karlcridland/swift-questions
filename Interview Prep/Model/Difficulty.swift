//
//  Difficulty.swift
//  Interview Prep
//
//  Created by Karl Cridland on 08/06/2025.
//

import UIKit

enum Difficulty: Int, Codable {
    
    case easy = 1
    case medium = 2
    case hard = 3
    
    var toString: String {
        return ["Easy", "Medium", "Hard"][rawValue - 1]
    }
    
    var color: UIColor? {
        switch(self) {
        case .easy:
            return .trafficLightGreen
        case .medium:
            return .trafficLightAmber
        case .hard:
            return .trafficLightRed
        }
    }
    
}
