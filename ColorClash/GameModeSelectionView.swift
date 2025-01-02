//
//  GameModeSelectionView.swift
//  ColorClash
//
//  Created by GuitarLearnerJas on 3/1/2025.
//

import SwiftUI

struct GameModeSelectionView: View {
    @Binding var isPresented: Bool
    @State private var showCasualGameView: Bool = false
    @State private var showMasterGameView: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Semi-transparent background
                Color.clear
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            isPresented = false
                        }
                    }
                
                // Popup content
                VStack(spacing: 20) {
                    Text("Select Game Mode")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.black.opacity(0.7))
                        .padding(.top, 30)
                    
                    VStack(spacing: 15) {
                        // Casual Mode Button
                        Button {
                            withAnimation {
                                isPresented = false
                                showCasualGameView = true
                            }
                        } label: {
                            HStack {
                                Image(systemName: "star")
                                    .font(.title2)
                                Text("Casual Mode")
                                    .font(.title3)
                                    .bold()
                            }
                            .frame(width: 200, height: 50)
                            .background(
                                LinearGradient(
                                    colors: [.blue.opacity(0.7), .green.opacity(0.7)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(15)
                        }
                        
                        // Master Mode Button
                        Button {
                            withAnimation {
                                isPresented = false
                                showMasterGameView = true
                            }
                        } label: {
                            HStack {
                                Image(systemName: "star.fill")
                                    .font(.title2)
                                Text("Master Mode")
                                    .font(.title3)
                                    .bold()
                            }
                            .frame(width: 200, height: 50)
                            .background(
                                LinearGradient(
                                    colors: [.purple.opacity(0.7), .red.opacity(0.7)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(15)
                        }
                    }
                    .padding(.vertical)
                    
                    // Cancel Button
                    Button {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            isPresented = false
                            dismiss()
                        }
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.gray)
                            .padding(.bottom)
                    }
                }
                .frame(width: 280)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .shadow(color: .gray.opacity(0.5), radius: 10)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
        .fullScreenCover(isPresented: $showCasualGameView) {
            CasualGameView()
        }
        .fullScreenCover(isPresented: $showMasterGameView) {
            MasterGameView()
        }
    }
}

// Extension for view modifier
extension View {
    func gameModePicker(isPresented: Binding<Bool>) -> some View {
        ZStack {
            self
            
            if isPresented.wrappedValue {
                GameModeSelectionView(isPresented: isPresented)
                    .transition(.opacity.combined(with: .scale))
            }
        }
    }
}
#Preview {
    GameModeSelectionView(isPresented: .constant(false))
}
