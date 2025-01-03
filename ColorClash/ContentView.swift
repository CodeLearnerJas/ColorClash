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
    
    @StateObject private var gameKitManager = GameKitManager.shared
    @StateObject private var versionManager = VersionManager()
    
    var body: some View {
        NavigationStack{
            ZStack{
                //Background Color
//                RadialGradient(stops: [
//                    .init(color: Color.blue.opacity(0.5), location: 0.1),
//                    .init(color: Color.red.opacity(0.3), location: 1)
//                ], center: .top, startRadius: 200, endRadius: 700)
                Image("BG")
                    .resizable()
                    .scaledToFill()
                .ignoresSafeArea()
                
                VStack {
                    HStack{
                        Spacer()
                        Button {
                            gameKitManager.showGameCenter()
                        } label: {
                            Image(systemName: "gamecontroller.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(gameKitManager.isGameCenterEnabled ? .primary : .secondary)
                                .offset(x: -50)
                        }
                    }
                    
                    Spacer()
                    
                    Text("Color Clash")
                        .foregroundStyle(.ultraThickMaterial)
                        .font(.system(size: 36, weight: .bold))
                    
                    // Version display
                    Text("v\(versionManager.currentVersion)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
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
        .onAppear {
            versionManager.checkForUpdates()
            gameKitManager.authenticateUser()
        }
        .gameModePicker(isPresented: $showGameMode)
        .fullScreenCover(isPresented: $showGameView) {
            CasualGameView()
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(isPresented: $showSettings)
                .presentationBackground(.clear)
        }
        .alert("Update Available", isPresented: $versionManager.showUpdateAlert) {
            Button("Update") {
                versionManager.openAppStore()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("A new version of ColorClash is available on the App Store.")
        }
    }
}

#Preview {
    ContentView()
}
