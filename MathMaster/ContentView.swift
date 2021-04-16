//
//  ContentView.swift
//  MathMaster
//
//  Created by Michael Lekrans on 2021-03-25.
//

import SwiftUI

struct ContentView: View {
    @State private var answerText: String = ""
    @State private var text: String = ""
    
    
    // MARK: - Properties
    private var padding: CGFloat = 10
    private var spacing: CGFloat = 10
    private var totalPadding: CGFloat {
        self.padding * 2 + self.spacing * 2
    }
    
    var body: some View {
        ZStack{
            Color.element.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            GeometryReader { geometry in
                VStack {
                    Text(text)
                    Spacer()
                    ButtonRow(buttons: ["Press to answer"], geometry: geometry, totalPadding: totalPadding, answerText: $answerText)
                    ButtonRow(buttons: ["1", "2", "3"], geometry: geometry, totalPadding: totalPadding, answerText: $answerText)
                    ButtonRow(buttons: ["4", "5", "6"], geometry: geometry, totalPadding: totalPadding, answerText: $answerText)
                    ButtonRow(buttons: ["7", "8", "9"], geometry: geometry, totalPadding: totalPadding, answerText: $answerText)
                    ButtonRow(buttons: ["empty", "0", "back"], geometry: geometry, totalPadding: totalPadding, answerText: $answerText)

                }.padding()
            }.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            SoundPlayerView(soundPlayer: SoundPlayer())
                        .opacity(0)
            SplashView()
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct NeoButton<Content: View>: View {
    let width: CGFloat
    let isBeveled: Bool
    let lightStyle: Bool
    let content: () -> Content
    let action: () -> Void
    
    init(width: CGFloat, isBeveled: Bool, lightStyle: Bool, @ViewBuilder content: @escaping() -> Content, action: @escaping () -> Void) {
        self.width = width
        self.isBeveled = isBeveled
        self.lightStyle = lightStyle
        self.content = content
        self.action = action
    }

    var body: some View {
        Button(action: self.action, label: {
            content()
        })
        .buttonStyle(NeoButtonStyle(width: width,
                                    height: 40,
                                    lightStyle: lightStyle,
                                    isBeveled: true))
    }
}

struct ButtonRow: View {
    let buttons: [String]
    let geometry: GeometryProxy
    let totalPadding: CGFloat
    @Binding var answerText: String
    
    
    var body: some View {
        HStack {
            ForEach(buttons, id: \.self) { button in
                if button == "empty" {
                    Text("").frame(width: smallButtonWidth(geometry: geometry, noOfButtonsPerRow: buttons.count))
                } else {
                    NeoButton(width: smallButtonWidth(geometry: geometry, noOfButtonsPerRow: buttons.count),
                              isBeveled: true, lightStyle: button == "back") {
                        VStack {
                            if button == "back" {
                                Image(systemName: "chevron.backward.2")
                            } else {
                                Text(button)
                            }
                        }
                    } action: {
                        answerText += button
                        print("\(answerText)")
                    }
                }
            }
        }.padding(.bottom, 1)
    }
    
    func smallButtonWidth(geometry: GeometryProxy, noOfButtonsPerRow: Int) -> CGFloat {
        (geometry.size.width - totalPadding) / CGFloat(noOfButtonsPerRow)
        
    }
}
