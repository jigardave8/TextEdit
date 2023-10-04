//
//  ContentView.swift
//  TextEdit
//
//  Created by Jigar on 04/10/23.
//




///
import SwiftUI

struct ContentView: View {
    @State private var text = ""
    @State private var isBold = false
    @State private var isItalic = false
    @State private var isUnderlined = false
    @State private var alignment: TextAlignment = .leading
    @State private var selectedFont: String = "Helvetica Neue"
    @State private var selectedEmoji: String = "😊"
    @State private var shadowRadius: CGFloat = 0
    @State private var shadowX: CGFloat = 0
    @State private var shadowY: CGFloat = 0
    @State private var shadowColor: Color = .black
    @State private var rotationAngle: Double = 0
    @State private var linkURL = ""
    @State private var highlightColor: Color = .yellow
    @State private var textColor: Color = .black
    @State private var bgColor: Color = .white
    @State private var showAlert = false
    
    var modifiedText: String {
        // Modify the text based on user preferences (bold, italic, underline, etc.)
        // You can format the text here using the selected options
        return "Modified Text: \(text)"
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    TextField("Enter text here", text: $text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                        .multilineTextAlignment(alignment)
                        .padding(1.0)
                    
                    Text(modifiedText)
                        .bold(isBold)
                        .italic(isItalic)
                        .underline(isUnderlined, color: .black)
                        .font(Font.custom(selectedFont, size: 18))
                        .foregroundColor(textColor)
                        .padding()
                        .background(bgColor)
                        .cornerRadius(10)
                        .shadow(color: shadowColor, radius: shadowRadius, x: shadowX, y: shadowY)
                        .rotationEffect(Angle(degrees: rotationAngle))
                        .background(highlightColor)
                        .padding()
                    
                    Button(action: {
                                 // Copy modified text to clipboard
                                 UIPasteboard.general.string = modifiedText
                                 showAlert = true // Show alert when text is copied
                             }) {
                                 Text("Copy Text")
                                     .padding()
                                     .background(Color.blue)
                                     .foregroundColor(.white)
                                     .cornerRadius(10)
                             }
                         
                         .padding()
                         .alert(isPresented: $showAlert) {
                             Alert(
                                 title: Text("Text Copied"),
                                 message: Text("The modified text has been copied to the clipboard."),
                                 dismissButton: .default(Text("OK"))
                             )
                         }
                    
                    ControlsView(isBold: $isBold, isItalic: $isItalic, isUnderlined: $isUnderlined,
                                 alignment: $alignment, selectedFont: $selectedFont, selectedEmoji: $selectedEmoji,
                                 shadowRadius: $shadowRadius, shadowX: $shadowX, shadowY: $shadowY,
                                 shadowColor: $shadowColor, rotationAngle: $rotationAngle, linkURL: $linkURL,
                                 highlightColor: $highlightColor, textColor: $textColor, bgColor: $bgColor,
                                 showAlert: $showAlert)
                        .padding()
                }
                .navigationBarTitle("Rich Text Editor")
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Text Copied"),
                        message: Text("The modified text has been copied to the clipboard."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }
}

struct ControlsView: View {
    @Binding var isBold: Bool
    @Binding var isItalic: Bool
    @Binding var isUnderlined: Bool
    @Binding var alignment: TextAlignment
    @Binding var selectedFont: String
    @Binding var selectedEmoji: String
    @Binding var shadowRadius: CGFloat
    @Binding var shadowX: CGFloat
    @Binding var shadowY: CGFloat
    @Binding var shadowColor: Color
    @Binding var rotationAngle: Double
    @Binding var linkURL: String
    @Binding var highlightColor: Color
    @Binding var textColor: Color
    @Binding var bgColor: Color
    @Binding var showAlert: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            
            Toggle("Bold", isOn: $isBold)
            Toggle("Italic", isOn: $isItalic)
            Toggle("Underline", isOn: $isUnderlined)
            
            Picker("Text Alignment", selection: $alignment) {
                Text("Left").tag(TextAlignment.leading)
                Text("Center").tag(TextAlignment.center)
                Text("Right").tag(TextAlignment.trailing)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Picker("Font Family", selection: $selectedFont) {
                Text("Helvetica Neue").tag("Helvetica Neue")
                Text("Times New Roman").tag("Times New Roman")
                Text("Courier New").tag("Courier New")
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Picker("Emoji", selection: $selectedEmoji) {
                Text("😊").tag("😊")
                Text("🚀").tag("🚀")
                Text("🎉").tag("🎉")
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Text("Shadow Radius: \(Int(shadowRadius))")
            Slider(value: $shadowRadius, in: 0...10, step: 1)
            
            Text("Shadow X: \(Int(shadowX))")
            Slider(value: $shadowX, in: -10...10, step: 1)
            
            Text("Shadow Y: \(Int(shadowY))")
            Slider(value: $shadowY, in: -10...10, step: 1)
            
            ColorPicker("Shadow Color", selection: $shadowColor)
                           .padding()
                       
                       Slider(value: $rotationAngle, in: 0...360, step: 1)
                       Text("Rotation Angle: \(Int(rotationAngle))°")
                           .padding()
                       
                       TextField("Enter link URL", text: $linkURL)
                           .textFieldStyle(RoundedBorderTextFieldStyle())
                           .padding()
                       
                       ColorPicker("Text Highlight Color", selection: $highlightColor)
                           .padding()
                       
                       ColorPicker("Text Color", selection: $textColor)
                           .padding()
                       
                       ColorPicker("Background Color", selection: $bgColor)
                           .padding()
     
        }
        .padding()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
///////

