//
//  About ColorClash.swift
//  ColorClash
//
//  Created by GuitarLearnerJas on 3/1/2025.
//
import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20){
            HStack{
                Spacer()
                Button{
                    dismiss()
                } label: {
                    Image(systemName: "chevron.down")
                }
            }
            
            Text("About ColorClash")
                .font(.title)
                .bold()
                .padding(.bottom, 50)

            Section("What is ColorClash?"){
                Text("ColorClash is a simple casual color mixing game where you will be randomly given a RGB color and you need to control the amount of Red, Green and Blue to get your mixed color as close as possible to the given color.\nChallenge your eyes right now!")
                    .foregroundStyle(.gray)
            }
            
            Section("Casual Mode"){
                Text("Free to move RGB slider to mix colors untill you are happy to check your color, start playing now!")
                    .foregroundStyle(.gray)
            }
            Section("Master Mode"){
                Text("This is for players who want a bit more challenge, you can only move one color slider at a time, once you move onto the next, the previous slider will be locked till checking, so be careful of your moves!")
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            Button(action: {
                openURL(URLManager().projectURL)
            }) {
                Text("Visit ColorClash Website")
                    .font(.subheadline)
                    .bold()
                    .minimumScaleFactor(0.8)
                    .foregroundColor(.white)
                    .frame(width: 250, height: 20)
                    .padding(10)
                    .background(Color.paleBlue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        
    }
}

#Preview {
    AboutView()
}
