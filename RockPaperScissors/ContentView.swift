//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Sean Dooley on 05/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var appMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var questionCount = 1
    @State private var showingFinalScore = false
    
    let moves = ["rock", "paper", "scissors"]
    //let moves = ["✊","✋","✌"]
    let maxQuestionCount = 10
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Rock, Paper, Scissors!")
                .font(.largeTitle.bold())
            
            Spacer()
            
            Text("App's move: \(moves[appMove])")
                .font(.title)
            
            Text(shouldWin ? "Your goal: Win!" : "Your goal: Lose!")
                .font(.title2)
                .padding()
                .background(shouldWin ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                .clipShape(Capsule())
            
            Spacer()
            
            HStack {
                ForEach(0..<3) { move in
                    Button(action: {
                        self.checkAnswer(playerMove: move)
                    }) {
                        Text(moves[move])
                            .font(.system(size: 24))
                            .padding()
                    }
                }
            }
            
            Spacer()
            
            Text("Score: \(score)")
                .font(.title)
            
            Spacer()
        }
        .padding()
        .alert("Game Over", isPresented: $showingFinalScore) {
            Button("Play Again", action: resetGame)
        } message: {
            Text("Your final score is \(score).")
        }
    }
    
    // Function to check player's answer
    func checkAnswer(playerMove: Int) {
        let isCorrect: Bool
        
        isCorrect = shouldWin
            ? (playerMove == (appMove + 1) % 3)
            : (appMove == (playerMove + 1) % 3)
        
        if isCorrect {
            score += 1
        } else {
            score -= 1
        }
        
        if questionCount == maxQuestionCount {
            // Game Over
            showingFinalScore = true
        } else {
            // Set up next round
            self.nextRound()
        }
    }
    
    func nextRound() {
        appMove = Int.random(in: 0...2)
        shouldWin.toggle()
        questionCount += 1
    }
    
    // Function to reset the game
    func resetGame() {
        score = 0
        questionCount = 1
        appMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
}

#Preview {
    ContentView()
}
