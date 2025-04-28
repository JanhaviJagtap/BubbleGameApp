//
//  BubbleModel.swift
//  BubbleTrouble
//
//  Created by Janhavi Jagtap on 23/4/2025.
//

import SwiftUI

enum BubbleColor: CaseIterable, Codable {
    case red, pink, green, blue, black

    var color: String {
        switch self {
        case .red: return "redbubble"
        case .pink: return "pinkbubble"
        case .green: return "greenbubble"
        case .blue: return "bluebubble"
        case .black: return "blackbubble"
        }
    }

    var points: Int {
        switch self {
        case .red: return 1
        case .pink: return 2
        case .green: return 5
        case .blue: return 8
        case .black: return 10
        }
    }
    
    static func randomByProbability() -> BubbleColor {
        let rand = Double.random(in: 0..<1)
        switch rand {
        case 0..<0.4: return .red
        case 0.4..<0.7: return .pink
        case 0.7..<0.85: return .green
        case 0.85..<0.95: return .blue
        default: return .black
        }
    }
}

struct Bubble: Identifiable {
    let id = UUID()
    let color: BubbleColor
    var position: CGPoint
    static let diameter: CGFloat = 60
}

struct HighScoreEntry: Identifiable, Codable {
    let id = UUID()
    let playerName: String
    let score: Int
    let date: Date
}
