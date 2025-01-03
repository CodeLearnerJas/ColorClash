//
//  GameView.swift
//  ColorClash
//
//  Created by GuitarLearnerJas on 2/1/2025.
//
import SwiftUI

struct CasualGameView: View {
    @State private var targetColor: Color = .random
    @State private var userRed: Double = 0.0
    @State private var userGreen: Double = 0.0
    @State private var userBlue: Double = 0.0
    @State private var score: Double = 0.0
    @State private var showingScore = false
    @State private var showLostAlert = false
    @State private var stage = 1
    @State private var accuracyArray: [Double] = [0.0]
    @State private var showContentView = false
    @State private var highestStage = 0
    @State private var scoreCurrent = 0
    
    var stageAccuracyReq: Double {
        guard stage > 0 else { return 95 }
        if stage <= 56 {
            return 70 + Double(stage / 2)
        } else {
            return 99
        }
    }
    
    // Convert Color to RGB components
       private var targetComponents: (red: Double, green: Double, blue: Double) {
           let components = UIColor(targetColor).cgColor.components ?? [0, 0, 0, 0]
           return (components[0], components[1], components[2])
       }
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack{
                RadialGradient(stops: [
                    .init(color: Color.blue.opacity(0.5), location: 0.1),
                    .init(color: Color.red.opacity(0.3), location: 1)
                ], center: .top, startRadius: 200, endRadius: 700)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    HStack{
                        Text("STAGE \(stage) - Casual")
                            .font(.system(size: 30))
                            .bold()
                            .foregroundStyle(.black.opacity(0.8))
                            .padding()
                        
                    }
                    Spacer()
                    
                    VStack{
                        HStack{
                            Text("Score:")
                            Text("\(scoreCurrent)")
                                .foregroundStyle(.paleRed)
                                .bold()
                        }
                        HStack{
                            Text("Accuracy to Pass:")
                            Text("\(String(format: "%.1f", stageAccuracyReq))%")
                                .foregroundStyle(.orange)
                                .bold()
                        }
                        
                        HStack {
                            Text("Highest Accuracy:")
                            Text("\(String(format: "%.1f", accuracyArray.max() ?? 0))%")
                                .foregroundStyle(.blue)
                                .bold()
                        }
                    }
                    
                    Spacer()
                    
                        // Target Color Display
                        VStack {
                            Text("Target Color")
                                .foregroundStyle(.black.opacity(0.7))
                                .font(.headline)
                            Rectangle()
                                .fill(targetColor)
                                .frame(height: 100)
                                .cornerRadius(20)
                        }
                        .padding()
                        
                        // User's Mixed Color
                        VStack {
                            Text("Your Mix")
                                .foregroundStyle(.black.opacity(0.7))
                                .font(.headline)
                            Rectangle()
                                .fill(Color(red: userRed, green: userGreen, blue: userBlue))
                                .frame(height: 100)
                                .cornerRadius(20)
                        }
                        .padding()
                        
                        // Color Sliders
                        VStack(spacing: 15) {
                            ColorSlider(value: $userRed, color: .red)
                            ColorSlider(value: $userGreen, color: .green)
                            ColorSlider(value: $userBlue, color: .blue)
                        }
                        .padding()
                        
                        // Submit Button
                    HStack{
                        Button{
                            showContentView.toggle()
                        } label: {
                            Text("Back")
                                .font(.headline)
                                .foregroundColor(.white)
                                .bold()
                                .padding()
                                .background(.ultraThinMaterial)
                                .cornerRadius(10)
                        }
                            Button(action: checkColor) {
                                Text("Check Color")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .bold()
                                    .padding()
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(10)
                            }
                        }
                    }
    
                }
                .alert("Great Job!", isPresented: $showingScore) {
                    Button("Back") {
                        dismiss()
                        showContentView.toggle()
                    }
                    Button("Next Stage"){
                        let accuracy = calculateAccuracy()
                        withAnimation(.easeInOut(duration: 0.7)) {
                            scoreCurrent += (500 + Int(accuracy * 1000 * (1 + accuracy)))
                        }
                        newGame()
                        stage += 1
                        highestStage = stage
                        let _ = print("Highest Stage: \(highestStage)")
                    }
                } message: {
                    Text("Your accuracy is: \(String(format: "%.1f", score))%")
                }
                .alert("Game Over", isPresented: $showLostAlert) {
                    Button("Back") {
                        dismiss()
                        showContentView.toggle()
                        scoreCurrent = 0
                    }
                    Button("Start Again") {
                        stage = 1
                        scoreCurrent = 0
                        newGame()
                    }
                } message: {
                    Text("Your accuracy is: \(String(format: "%.1f", score))%")
                }
                .fullScreenCover(isPresented: $showContentView) {
                    ContentView()
                }
            
            }
        }
        
        func checkColor() {
            let accuracy = calculateAccuracy()
            score = Double(accuracy * 100)
            accuracyArray.append(score)
            
                if score >= stageAccuracyReq {
                    //can go next
                    showingScore = true
                } else {
                    //lose
                    showLostAlert = true
                }
            }
            
        func calculateAccuracy() -> Double {
            let targetRGB = targetComponents
            let redDiff = abs(targetRGB.red - userRed)
            let greenDiff = abs(targetRGB.green - userGreen)
            let blueDiff = abs(targetRGB.blue - userBlue)
            
            // Calculate accuracy (1.0 is perfect match, 0.0 is completely off)
            return 1 - ((redDiff + greenDiff + blueDiff) / 3.0)
        }
        
        func newGame() {
            targetColor = .random
            userRed = 0.0
            userGreen = 0.0
            userBlue = 0.0
        }
    }


#Preview {
    CasualGameView()
}
