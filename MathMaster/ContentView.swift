//
//  ContentView.swift
//  MathMaster
//
//  Created by Michael Lekrans on 2021-03-25.
//

import SwiftUI
import MLKeyboardLib
import MLMathMasterEngine

struct ContentView: View {
    @State private var answerText: String = ""
    @State private var text: String = ""
        
    @State var category: MLMathMasterGameCategory?
    
    @StateObject var keyboard2 = MLNumericKeyboard()
    @StateObject var engine = MLMathMasterEngine()
    var soundPlayer = SoundPlayer()
    
    
    
    // MARK: - Properties
    private var padding: CGFloat = 10
    private var spacing: CGFloat = 10
    private var totalPadding: CGFloat {
        self.padding * 2 + self.spacing * 2
    }
    
    fileprivate func handleNewQuestion() {
        answerText = keyboard2.text
        keyboard2.text = ""
        keyboard2.submitted = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            do {
                try engine.qm?.activateNextQuestion()
                answerText = ""
            } catch {
                print("Error \(error), \(error.localizedDescription)")
            }
        }
    }
    
    var body: some View {
        ZStack{

            Color.element.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            SoundPlayerView(soundPlayer: soundPlayer)
                        .opacity(0)
                .frame(height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Group {
                
                VStack {
                    TopView(model: engine, category: $category, answer: $answerText, keyboardText: $keyboard2.text)
                    
                    if engine.gameState == .started {
                        MLNumKeyView(keyboard: keyboard2, configuration: MLNumKeyViewConfiguration(returnKey: .top))
                            .frame(width: nil, height: 300)
                    } else if engine.gameState == .stopped {
                        NewGameView(model: engine, category: $category)
                    }
                }.padding()
            }.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            .onChange(of: keyboard2.submitted, perform: { value in
                if value == true {
                    handleNewQuestion()
                }
            })
            
            
            SplashView()
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




