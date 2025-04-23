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
    @Published var timeLeft: Int = 59

    private var lastPoppedColor: BubbleColor?
    private var consecutiveCount: Int = 0
    private var timer: Timer?

    func startGame() {
        score = 0
        timeLeft = 59
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
        var newBubbles: [Bubble] = []
        var count = 0
        for _ in 0..<15 {
            var bubble: Bubble
            var collision = true
            var attempts = 0
            repeat {
                let color = BubbleColor.allCases.randomElement()!
                let position = CGPoint(x: CGFloat.random(in: 40...340), y: CGFloat.random(in: 90...640))
                bubble = Bubble(color: color, position: position)
                collision = newBubbles.contains { existingBubble in
                    distanceBetween(bubble.position, existingBubble.position) < 70
                }
                attempts += 1
            } while collision && attempts < 100
            count+=1
            if(count>=8){
                count = 0;
                break
            }
            newBubbles.append(bubble)
        }
        bubbles = newBubbles
        
        
        func distanceBetween(_ p1: CGPoint, _ p2: CGPoint) -> CGFloat {
            sqrt(pow(p2.x - p1.x, 2) + pow(p2.y - p1.y, 2))
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
