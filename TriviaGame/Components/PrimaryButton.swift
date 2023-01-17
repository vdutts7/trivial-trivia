//
//  PrimaryButton.swift
//  TriviaGame
//
//

import SwiftUI

struct PrimaryButton: View {
    var text: String
    var background: Color = Color(red: 0.0, green: 0.8, blue: 1.0)
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .padding()
            .padding(.horizontal)
            .background(background)
            .cornerRadius(30)
            .shadow(radius: 10)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(text: "Next")
    }
}
