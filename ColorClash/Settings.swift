//
//  Settings.swift
//  ColorClash
//
//  Created by GuitarLearnerJas on 3/1/2025.
//

import SwiftUI

struct SettingsView: View {
    @Binding var isPresented: Bool
     @State var soundOn: Bool = false
     @State private var showAboutView: Bool = false
     
     var body: some View {
         GeometryReader { geometry in
             ZStack {
                 // Semi-transparent background
                 Color.clear.opacity(0.01)
                     .ignoresSafeArea()
                     .onTapGesture {
                         withAnimation(.easeInOut(duration: 0.2)) {
                             isPresented = false
                         }
                     }
                 
                 // Settings popup content
                 VStack(spacing: 15) {
                     Text("Settings")
                         .font(.title2)
                         .bold()
                         .foregroundColor(.black)
                         .padding(.top)
                     
                     // Sound Toggle Button
                     Button(action: {
                         soundOn.toggle()
                     }) {
                         Text(soundOn ? "Sound Now ON" : "Sound Now OFF")
                             .font(.subheadline)
                             .minimumScaleFactor(0.8)
                             .foregroundColor(.white)
                             .frame(width: 120, height: 20)
                             .padding(10)
                             .background(soundOn ? Color.paleBlue2.opacity(0.9) : Color.gray.opacity(0.8))
                             .cornerRadius(10)
                     }
                     .animation(.easeInOut, value: soundOn)
                     
                     // Get Rid of Ads Button
                     Button(action: {
                         //
                     }) {
                         Text("Get Rid Of Ads")
                             .font(.subheadline)
                             .minimumScaleFactor(0.8)
                             .foregroundColor(.white)
                             .frame(width: 120, height: 20)
                             .padding(10)
                             .background(Color.paleBlue2)
                             .cornerRadius(10)
                     }
                     
                     // About Button
                     Button(action: {
                         showAboutView.toggle()
                     }) {
                         Text("About ColorClash")
                             .font(.subheadline)
                             .minimumScaleFactor(0.8)
                             .foregroundColor(.white)
                             .frame(width: 120, height: 20)
                             .padding(10)
                             .background(Color.paleBlue2)
                             .cornerRadius(10)
                     }
                     
                     // Privacy Policy Button
                     Button(action: {
                         openURL(URLManager().privacyURL)
                     }) {
                         Text("Privacy Policy")
                             .font(.subheadline)
                             .minimumScaleFactor(0.8)
                             .foregroundColor(.white)
                             .frame(width: 120, height: 20)
                             .padding(10)
                             .background(Color.paleBlue2)
                             .cornerRadius(10)
                     }
                     
                     // Terms Button
                     Button(action: {
                         openURL(URLManager().termsURL)
                     }) {
                         Text("Terms of Service")
                             .font(.subheadline)
                             .minimumScaleFactor(0.8)
                             .foregroundColor(.white)
                             .frame(width: 120, height: 20)
                             .padding(10)
                             .background(Color.paleBlue2)
                             .cornerRadius(10)
                     }
                     
                     // Cancel Button
                     Button {
                         withAnimation(.easeInOut(duration: 0.2)) {
                             isPresented = false
                         }
                     } label: {
                         Text("Close")
                             .foregroundStyle(.ultraThickMaterial)
                             .padding(.vertical, 8)
                     }
                 }
                 .padding(.vertical)
                 .frame(width: 230)
                 .background(.ultraThinMaterial)
                 .cornerRadius(20)
                 .shadow(radius: 15)
                 .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
             }
         }
         .sheet(isPresented: $showAboutView) {
             AboutView()
         }
     }
 }

 // Extension for view modifier
 extension View {
     func settingsPopup(isPresented: Binding<Bool>) -> some View {
         ZStack {
             self
             
             if isPresented.wrappedValue {
                 SettingsView(isPresented: isPresented)
                     .transition(.opacity.combined(with: .scale))
             }
         }
     }
 }

#Preview {
    SettingsView(isPresented: .constant(false))
}
