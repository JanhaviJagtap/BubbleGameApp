//
//  GameViewModel.swift
//  BubbleTrouble
//
//  Created by Janhavi Jagtap on 23/4/2025.
//
import SwiftUI

class BubblePopViewModel: ObservableObject {
    @Published var bubbles: [Bubble] = []
    @Published var score: Int = 0
    @Published var timeLeft: Int = 60

    private var lastPoppedColor: BubbleColor?
    private var consecutiveCount: Int = 0
    private var timer: Timer?

    func startGame() {
        score = 0
        timeLeft = 60
        lastPoppedColor = nil
        consecutiveCount = 0
        bubbles = []
        startTimer()
        spawnBubbles()
    }

    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.timeLeft -= 1
            if self.timeLeft <= 0 {
                self.timer?.invalidate()
            } else {
                self.spawnBubbles()
            }
        }
    }

    func spawnBubbles() {
        // Example: spawn 10 bubbles at random positions
        bubbles = (0..<10).map { _ in
            let color = BubbleColor.allCases.randomElement()!
            let position = CGPoint(x: CGFloat.random(in: 40...300), y: CGFloat.random(in: 100...600))
            return Bubble(color: color, position: position)
        }
    }

    func popBubble(_ bubble: Bubble) {
        if let index = bubbles.firstIndex(where: { $0.id == bubble.id }) {
            bubbles.remove(at: index)
            var points = bubble.color.points
            if lastPoppedColor == bubble.color {
                consecutiveCount += 1
                points = Int(Double(points) * 1.5)
            } else {
                consecutiveCount = 1
            }
            lastPoppedColor = bubble.color
            score += points
        }
    }
}
