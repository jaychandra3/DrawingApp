//
//  Configurations.swift
//  Neuro Platform
//
//  Created by user175482 on 12/27/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import Foundation
import SwiftUI

// Button Styles
struct MainButtonStyle : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(configuration.isPressed ? .gray : .white)
            .padding()
            .background(configuration.isPressed ? Color(red: 0.1, green: 0.1, blue: 0.1, opacity: 1) : .gray)
            .cornerRadius(8)
    }
}

// Text Styles
struct TitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .lineSpacing(8)
            .foregroundColor(.primary)
    }
}

// Extensions
extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}
