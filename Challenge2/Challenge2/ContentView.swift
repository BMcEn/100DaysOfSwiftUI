//
//  ContentView.swift
//  Challenge2
//
//  Created by Benjamin McEnulty on 3/14/22.
//

import SwiftUI

struct ContentView: View {
    let moves = ["Rock", "Paper", "Scissors"]
    let winningMoves = ["Paper", "Scissors", "Rock"]
    let losingMoves = ["Scissors", "Rock", "Paper"]
    @State private var appChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    
    
    var body: some View {
        VStack {
            Text("Score: \(score)")
            Text("App chooses: \(moves[appChoice])")
            Text(shouldWin ? "You must win" : "You must lose")
            ForEach(0..<moves.count) { index in
                Button(moves[index]) {
                    CheckAnswer(for: index)
                }
            }
        }
    }
    
    func CheckAnswer(for move: Int) {
        var status: Bool {
            //Returns True if:
            
            //you correctly picked the winning option
            shouldWin && winningMoves[appChoice] == moves[move]
            
            //or you correctly picked the losing option
            || !shouldWin && losingMoves[appChoice] == moves[move]
        }
        
        updateScore(scored: status)
    }
    
    func updateScore(scored: Bool) {
        if scored {
            score += 1
        } else {
            score -= 1
        }
        
        newRound()
    }
    
    func newRound() {
        appChoice = Int.random(in: 0..<moves.count)
        shouldWin.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
