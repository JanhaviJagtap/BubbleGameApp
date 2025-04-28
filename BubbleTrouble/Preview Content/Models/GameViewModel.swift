//
//  GameViewModel.swift
//  BubbleTrouble
//
//  Created by Janhavi Jagtap on 23/4/2025.
//
import SwiftUI
import AVFoundation

class BubblePopViewModel: ObservableObject {
    @Published var bubbles: [Bubble] = []
    @Published var score: Int = 0
    @Published var timeLeft: Int = 60
    @Published var highScores: [HighScoreEntry] = []
    @Published var gameState: GameState = .menu
    
    var playerName: String = ""
    var maxBubbles: Int = 15
    var gameDuration: Int = 60

    private var lastPoppedColor: BubbleColor?
    private var consecutiveCount: Int = 0
    private var timer: Timer?
    private var audioPlayer: AVAudioPlayer?

    enum GameState { case menu, playing, gameOver }

    init() { loadHighScores() }

    func startGame() {
        score = 0
        timeLeft = gameDuration
        lastPoppedColor = nil
        consecutiveCount = 0
        gameState = .playing
        bubbles = []
        startTimer()
        spawnBubbles()
    }

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.tick()
        }
    }

    private func tick() {
        guard gameState == .playing else { return }
        timeLeft -= 1
        if timeLeft <= 0 {
            timer?.invalidate()
            endGame()
        } else {
            refreshBubbles()
        }
    }
    
    private func refreshBubbles() {
        // Remove random number of bubbles (up to half, at least 1 if present)
        let count = bubbles.count
        if count > 0 {
            let removeCount = Int.random(in: 1...max(1, count/2))
            let indicesToRemove = Array(bubbles.indices.shuffled().prefix(removeCount)).sorted(by: >)
            for idx in indicesToRemove { bubbles.remove(at: idx) }
        }
        spawnBubbles()
    }

    func spawnBubbles() {
        let toAdd = maxBubbles - bubbles.count
        guard toAdd > 0 else { return }
        var newBubbles: [Bubble] = []
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let screenHeight: CGFloat = UIScreen.main.bounds.height * 0.7 // keep bubbles in visible area

        for _ in 0..<toAdd {
            var pos: CGPoint
            var collision: Bool
            var attempts = 0
            repeat {
                let x = CGFloat.random(in: Bubble.diameter/2...(screenWidth - Bubble.diameter))
                let y = CGFloat.random(in: Bubble.diameter/2...(screenHeight - Bubble.diameter))
                pos = CGPoint(x: x, y: y)
                collision = (bubbles + newBubbles).contains { existing in
                    hypot(existing.position.x - x, existing.position.y - y) < Bubble.diameter+20
                }
                attempts += 1
            } while collision && attempts < 100
            let color = BubbleColor.randomByProbability()
            newBubbles.append(Bubble(color: color, position: pos))
        }
        bubbles += newBubbles
        
        func distanceBetween(_ p1: CGPoint, _ p2: CGPoint) -> CGFloat {
            sqrt(pow(p2.x - p1.x, 2) + pow(p2.y - p1.y, 2))
        }
    }
    
    func popBubble(_ bubble: Bubble) {
        guard let idx = bubbles.firstIndex(where: { $0.id == bubble.id }) else { return }
        bubbles.remove(at: idx)
        var points = bubble.color.points
        if lastPoppedColor == bubble.color {
            consecutiveCount += 1
            points = Int(round(Double(points) * 1.5))
        } else {
            consecutiveCount = 1
        }
        lastPoppedColor = bubble.color
        score += points
        playPopSound()
    }

    private func playPopSound() {
        guard let url = Bundle.main.url(forResource: "pop", withExtension: "wav") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch { print("Sound error: \(error)") }
    }

    private func endGame() {
        saveHighScore()
        gameState = .gameOver
    }
    
    func saveHighScore() {
        guard !playerName.isEmpty else { return }
        let entry = HighScoreEntry(playerName: playerName, score: score, date: Date())
        highScores.append(entry)
        highScores.sort { $0.score > $1.score }
        if highScores.count > 10 { highScores = Array(highScores.prefix(10)) }
        if let encoded = try? JSONEncoder().encode(highScores) {
            UserDefaults.standard.set(encoded, forKey: "highScores")
        }
    }

    func loadHighScores() {
        if let data = UserDefaults.standard.data(forKey: "highScores"),
           let decoded = try? JSONDecoder().decode([HighScoreEntry].self, from: data) {
            highScores = decoded.sorted { $0.score > $1.score }
        }
    }

    func resetGame() {
        gameState = .menu
        score = 0
        timeLeft = gameDuration
        bubbles = []
        lastPoppedColor = nil
        consecutiveCount = 0
    }

}
