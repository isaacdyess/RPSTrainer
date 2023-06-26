//
//  ContentView.swift
//  RPSTrainer
//
//  Created by Isaac Dyess on 6/24/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var gameOver = false
    
    @State private var inputOptions = ["rock", "paper", "scissors"]
    @State private var winCondition = ["paper", "scissors", "rock"]
    @State private var loseCondition = ["scissors", "rock", "paper"]
    
    @State private var cpuInputSelection = Int.random(in: 0...2)
    @State private var goalToWin = Bool.random()
    
    @State private var userScore = 0
    @State private var currentRound = 1
    
    var body: some View {
        ZStack {
            Color.mint
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                VStack {
                    Text("CPU Selection:")
                        .font(.title)
                        .foregroundColor(.white)
                    OptionImage(option: inputOptions[cpuInputSelection])
                    
                    Text("You Need to...")
                        .font(.title)
                        .foregroundColor(.white)
                    Text(goalToWin ? "WIN!" : "LOSE!")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                }
                
                Spacer()
                HStack {
                    ForEach(0..<3) { number in
                        Button {
                            optionTapped(number)
                        } label: {
                            OptionImage(option: inputOptions[number])
                        }
                    }
                }
                Spacer()
                
                Text("Your Score: \(userScore)")
                    .foregroundColor(.white)
                Text("Current Round: \(currentRound)")
                    .foregroundColor(.white)
            }
            .padding()
            .alert(scoreTitle, isPresented: $showingScore) {
                if !gameOver {
                    Button("Continue", action: nextRound)
                } else {
                    Button("Restart", action: newGame)
                }
            } message: {
                if !gameOver {
                    Text("Your score is now \(userScore)")
                } else {
                    Text("Your final score is \(userScore)")
                }
            }
        }
    }
    
    func optionTapped(_ number: Int) {
        if (goalToWin && winCondition[cpuInputSelection] ==
            inputOptions[number]) {
            userScore += 1
            scoreTitle = "CORRECT!"
        } else if (!goalToWin && loseCondition[cpuInputSelection] == inputOptions[number]) {
            userScore += 1
            scoreTitle = "CORRECT!"
        } else {
            userScore -= 1
            scoreTitle = "WRONG!"
        }
        
        if (currentRound == 10) {
            gameOver = true
        }
        
        showingScore = true
    }
    
    func nextRound() {
        cpuInputSelection = Int.random(in: 0...2)
        goalToWin.toggle()
        currentRound += 1
    }
    
    
    func newGame() {
        cpuInputSelection = Int.random(in: 0...2)
        goalToWin = Bool.random()
        currentRound = 1
        userScore = 0
        gameOver = false
    }
}

struct OptionImage: View {
    var option: String

    var body: some View {
        Image(option)
            .resizable()
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
            .frame(width: 120.0, height: 120.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
