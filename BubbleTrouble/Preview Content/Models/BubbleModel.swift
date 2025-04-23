//
//  BubbleModel.swift
//  BubbleTrouble
//
//  Created by Janhavi Jagtap on 23/4/2025.
//

import SwiftUI

enum BubbleColor: CaseIterable {
    case red, pink, green, blue, black

    var color: Color {
        switch self {
        case .red: return .red
        case .pink: return .pink
        case .green: return .green
        case .blue: return .blue
        case .black: return .black
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
