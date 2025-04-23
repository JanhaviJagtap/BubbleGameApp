//
//  BubbleModel.swift
//  BubbleTrouble
//
//  Created by Janhavi Jagtap on 23/4/2025.
//

import SwiftUI

enum BubbleColor: CaseIterable {
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
}

struct Bubble: Identifiable {
    let id = UUID()
    let color: BubbleColor
    var position: CGPoint
}
