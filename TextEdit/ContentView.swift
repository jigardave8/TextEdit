//
//  ContentView.swift
//  TextEdit
//
//  Created by Jigar on 04/10/23.
//


import SwiftUI

struct ContentView: View {
    @State private var text = ""
    @State private var isBold = false
    @State private var isItalic = false
    @State private var isUnderlined = false

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    TextField("Enter text here", text: $text)
                        .font(.body)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .multilineTextAlignment(.center)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle()) // Apply a rounded border style

                    Text(text)
                        .font(.body)
                        .bold(isBold)
                        .italic(isItalic)
                        .underline(isUnderlined, color: .black)
                        .padding()
                }

                FormattingControlsView(isBold: $isBold, isItalic: $isItalic, isUnderlined: $isUnderlined)
                    .padding()
            }
            .navigationBarTitle("Rich Text Editor")
            .padding()
        }
    }
}

struct FormattingControlsView: View {
    @Binding var isBold: Bool
    @Binding var isItalic: Bool
    @Binding var isUnderlined: Bool

    var body: some View {
        HStack {
            Toggle("Bold", isOn: $isBold)
            Toggle("Italic", isOn: $isItalic)
            Toggle("Underline", isOn: $isUnderlined)
        }
        .padding()
    }
}
