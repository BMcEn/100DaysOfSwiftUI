//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Benjamin McEnulty on 9/20/20.
//  Copyright © 2020 ROSC. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingResults = false
    @State private var resultsTitle = ""
    @State private var computerChoice = Int.random(in: 0 ..< 3)
    @State private var shouldWin = Bool.random()
    let choices = ["Rock", "Paper", "Scissors"]

    
    var body: some View {
        VStack(spacing: 30) {
            Text("The computer will throw \(choices[computerChoice])")
            Text("You must \(shouldWin ? "win" : "lose")")
            ForEach(0 ..< choices.count) { number in
                Button("\(self.choices[number])", action: {
                    self.choiceTapped(number)
                })
            }
        }
        .alert(isPresented: $showingResults) {
            Alert(title: Text(resultsTitle),
                  message: Text("OK"),
                  dismissButton: .default(Text("Again")) {
                    self.newGame()
                })
        }
    }
    
    func choiceTapped(_ number: Int) {
        let outcome = getMatchOutcome(player: number, computer: computerChoice)
        
        if (didActuallyWin(outcome: outcome)) {
            resultsTitle = "Correct!"
        } else {
            resultsTitle = "Incorrect!"
        }
        
        showingResults = true
    }
    
    func getMatchOutcome(player: Int, computer: Int) -> MatchOutcome {
        if ((player + 1) % 3 == computer) {
            return MatchOutcome.lose
        } else if (player == computer) {
            return MatchOutcome.tie
        }
        return MatchOutcome.win
    }
    
    func didActuallyWin(outcome: MatchOutcome) -> Bool {
        if (outcome == MatchOutcome.win && shouldWin) {
            return true
        } else if (outcome == MatchOutcome.lose && !shouldWin) {
            return true
        }
        return false
    }
    
    func newGame() {
        computerChoice = Int.random(in: 0 ..< 3)
        shouldWin = Bool.random()
    }
}

enum MatchOutcome {
    case win
    case lose
    case tie
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
