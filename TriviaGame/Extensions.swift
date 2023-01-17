//
//  Extensions.swift
//  TriviaGame
//
//

import Foundation
import SwiftUI

// Custom modifier to call this one-liner instead of adding three modifiers every time we create a title Text.
extension Text {
    func myTitle() -> some View {
        self.font(.title)
            .fontWeight(.heavy)
            .foregroundColor(Color(red: 0.0, green: 0.8, blue: 1.0))

    }
}
