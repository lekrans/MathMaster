//
//  TopView.swift
//  MathMaster
//
//  Created by Michael Lekrans on 2021-05-16.
//

import SwiftUI
import MLMathMasterEngine

struct TopView: View {
    @ObservedObject var model: MLMathMasterEngine
    @Binding var category: MLMathMasterGameCategory?
    @State var type: MLMathMasterGameType?
    @State var noOfQuestions: Int?
    @State var maxTermValue: Int?
    @State var timeAttackTime: MLMathMasterGameTimeAttackTime?
    @Binding var answer: String
    @Binding var keyboardText: String
    
    
    var headLineText: String {
        if category == nil {
             return "SELECT GAME CATEGORY"
        } else if model.gameState == .none {
            return "SET UP GAME"
        } else if model.gameState == .started {
            return ""
        } else if model.gameState == .stopped {
            return "RESULT"
        } else {
            return ""
        }
    }
    var body: some View {
        VStack {
            Text(headLineText).font(Font.custom("Chalkduster", size: 15))
//            switch model.gameState {
//            case .none:
//                Text("none")
//            case .initialized:
//                Text("Initialized")
//            case .started:
//                Text("Started")
//            case .timeAttackStarted:
//                Text("TimeAttackStarted")
//            case .stopped:
//                Text("Stopped")
//            }
                
            Spacer()
            if category == nil {
                CategorySelectView(model: model, category: $category)
            } else if model.gameState == .none {
                GameSetupView(model: model, category: $category)
            } else if model.gameState == .started || model.gameState == .timeAttackStarted {
                GameView(model: model, answer: $answer, keyboardText: $keyboardText)
            } else if model.gameState == .stopped {
                ResultView(model: model)
            } else {
                Text("Something went wrong")
            }
            Spacer()
        }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView(model: MLMathMasterEngine(), category: .constant(.add), answer: .constant("20"), keyboardText: .constant("20"))
            .preferredColorScheme(.dark)
    }
}
