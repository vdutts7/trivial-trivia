//
//  ContentView.swift
//  TriviaGame
//
//

import SwiftUI

struct ContentView: View {
    @StateObject var triviaManager = TriviaManager()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                VStack(spacing: 20) {
                    Text("Trivial Trivia")
                        .myTitle()
                        .foregroundColor(Color(red: 0.0, green: 0.8, blue: 1.0))

                    Text("You ready bruh?")
                        .foregroundColor(Color(red: 0.0, green: 0.8, blue: 1.0))
                }
                
                NavigationLink {
                    TriviaView()
                        .environmentObject(triviaManager)
                } label: {
                    PrimaryButton(text: "Let's go!")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color(red: 0.0, green: 0.0, blue: 0.0))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
