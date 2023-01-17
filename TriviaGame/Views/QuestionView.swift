//
//  QuestionView.swift
//  TriviaGame
//
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var triviaManager: TriviaManager

    var body: some View {
        VStack(spacing: 40) {
            HStack {
                Text("Trivia Game")
                    .myTitle()
                
                Spacer()
                
                Text("\(triviaManager.index + 1) out of \(triviaManager.length)")
                    .foregroundColor(Color(red: 0.0, green: 0.8, blue: 1.0))
                    .fontWeight(.heavy)
            }
            
            ProgressBar(progress: triviaManager.progress)
            
            VStack(alignment: .leading, spacing: 20) {                
                Text(triviaManager.question)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.black)
                
                ForEach(triviaManager.answerChoices, id: \.id) { answer in
                    AnswerRow(answer: answer)
                        .environmentObject(triviaManager)
                }
            }
            
            Button {
                triviaManager.goToNextQuestion()
            } label: {
                PrimaryButton(text: "Next", background: triviaManager.answerSelected ? Color(red: 0.0, green: 0.8, blue: 1.0) : Color(hue: 1.0, saturation: 0.0, brightness: 0.564, opacity: 0.327))
            }
            .disabled(!triviaManager.answerSelected)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(red: 0.0, green: 0.8, blue: 1.0))
        .navigationBarHidden(true)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
            .environmentObject(TriviaManager())
    }
}
