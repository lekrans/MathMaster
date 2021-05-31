//
//  GameSetupView.swift
//  MathMaster
//
//  Created by Michael Lekrans on 2021-05-16.
//

import SwiftUI
import MLMathMasterEngine

struct GameSetupView: View {
    @ObservedObject var model: MLMathMasterEngine
    @State var gameType: MLMathMasterGameType = .sequence
    @State var timeAttackTime: MLMathMasterGameTimeAttackTime = .oneMin
    @State var noOfQuestions: Int = 10
    @State var maxTermValue: Int = 50
    @State var base: [Int] = [2,6]
    @Binding var category: MLMathMasterGameCategory?
    
    
    var body: some View {
        VStack {
            List {
                
                Section(header: Text("Game type")) {
                    Picker(selection: $gameType, label: Text("What is your favorite color?")) {
                        ForEach(MLMathMasterGameType.allCases) {
                            Text($0.name).tag($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }.font(Font.custom("Chalkduster", size: 15))
                
                Section(header: Text("No of questions")) {
                    Picker(selection: $noOfQuestions, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/, content: {
                        ForEach([10, 11, 20, 30, 40, 50], id: \.self) {
                            Text(String($0))
                        }
                    }).pickerStyle(SegmentedPickerStyle())
                    
                    .frame(width: nil, height: 30)
                }.font(Font.custom("Chalkduster", size: 15))
                
                Section(header: Text("Base values")) {
                    BaseSelectionView(base: $base)
                }.font(Font.custom("Chalkduster", size: 15))
                
                if gameType != .sequence {
                Section(header: Text("Max term value")) {
                    Picker(selection: $maxTermValue, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/, content: {
                        ForEach([10, 20, 30, 40, 50, 100, 200, 500], id: \.self) {
                            Text(String($0))
                        }
                    }).pickerStyle(SegmentedPickerStyle())
                    .font(Font.custom("Chalkduster", size: 30))
                }.font(Font.custom("Chalkduster", size: 15))
                }
                
                
                if gameType.isTimeAttack {
                    Section(header: Text("Time attack time")) {
                        Picker(selection: $timeAttackTime, label: Text("What is your favorite color?")) {
                            ForEach(MLMathMasterGameTimeAttackTime.allCases) {
                                Text($0.name)
                                    .font(.title)
                                    .tag($0)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                        do {
                            if gameType.isTimeAttack {
                                model.newTimeAttackGame(category: category!, max: maxTermValue, base: base, timeAttackTime: timeAttackTime)
                            } else {
                                if gameType != .sequence {
                                    gameType = .random(maxTermValue)
                                }
                                model.newGame(category: category!, type: gameType, base: base, noOfQuestions: noOfQuestions)
                            }
                            try model.qm?.activateNextQuestion()
                        } catch {
                            print("Error \(error), \(error.localizedDescription)")
                        }
                    }, label: {
                        Text("START GAME")
                    }).buttonStyle(NeoButtonStyle(width: 250, height: 50, lightStyle: true, innerColor: Color.green, isBeveled: true ))
                    Spacer()
                }
            }.listStyle(GroupedListStyle())
        }.font(Font.custom("Chalkduster", size: 30))
    }
    
}



struct GameSetupView_Previews: PreviewProvider {
    static var previews: some View {
        GameSetupView(model: MLMathMasterEngine(), category: .constant(.add))
            .preferredColorScheme(.dark)
    }
}

