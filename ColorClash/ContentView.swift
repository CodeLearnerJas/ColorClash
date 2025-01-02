//
//  ContentView.swift
//  ColorClash
//
//  Created by GuitarLearnerJas on 2/1/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var showGameView: Bool = false
    @State private var showGameMode: Bool = false
    @State private var showSettings: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                //Background Color
                RadialGradient(stops: [
                    .init(color: Color.blue.opacity(0.5), location: 0.1),
                    .init(color: Color.red.opacity(0.3), location: 1)
                ], center: .top, startRadius: 200, endRadius: 700)
                    .ignoresSafeArea()
                
                
                VStack {
                    HStack{
                        Spacer()
                        Button {
                            //game center
                        } label: {
                            Image(systemName: "gamecontroller.circle.fill")
                                .font(.system(size: 30))
                        }
                    }
                    
                    Spacer()
                    
                    Text("Color Clash")
                        .font(.system(size: 36, weight: .bold))
                    
                    Spacer()
                    
                    Button {
                        withAnimation(.easeInOut(duration: 0.4)) {
                                                 showGameMode = true
                                             }
                    } label: {
                        Text("Start")
                            .font(.title3)
                            .bold()
                            .frame(width: 100, height: 40)
                            .background(Color.red.opacity(0.75))
                            .foregroundStyle(.white)
                            .cornerRadius(10)
                    }
                    
                    Button {
                        showSettings.toggle()
                    } label: {
                        Text("Setting")
                            .font(.title3)
                            .bold()
                            .frame(width: 100, height: 40)
                            .background(Color.green.opacity(0.75))
                            .foregroundStyle(.white)
                            .cornerRadius(10)
                    }
                    
                    Button {
                        //share rate app
                    } label: {
                        Text("Loving it!")
                            .font(.title3)
                            .bold()
                            .frame(width: 100, height: 40)
                            .background(Color.blue.opacity(0.75))
                            .foregroundStyle(.white)
                            .cornerRadius(10)
                    }
                    
                }
                .padding()
            }
        }
        .gameModePicker(isPresented: $showGameMode)
        .fullScreenCover(isPresented: $showGameView) {
            CasualGameView()
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(isPresented: $showSettings)
                .presentationBackground(.clear)
        }
    }
}

#Preview {
    ContentView()
}
