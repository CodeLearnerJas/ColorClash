//
//  Untitled.swift
//  ColorClash
//
//  Created by GuitarLearnerJas on 2/1/2025.
//
import SwiftUI

struct ColorSlider: View {
    @Binding var value: Double
    let color: Color
    
    var body: some View {
        HStack {
            Text(color == .red ? "R" : color == .green ? "G" : "B")
                .foregroundColor(color)
                .font(.headline)
            Slider(value: $value, in: 0...1, step: 0.01)
                .accentColor(color)
            Text("\(Int(value * 255))")
                .frame(width: 40)
        }
    }
}

extension Color {
    static var random: Color {
        Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
}

#Preview {
    ColorSlider(value: .constant(0), color: .red)
}
