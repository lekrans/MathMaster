//
//  NewGameView.swift
//  MathMaster
//
//  Created by Michael Lekrans on 2021-05-17.
//

import SwiftUI
import MLMathMasterEngine

struct NewGameView: View {
    @ObservedObject var model: MLMathMasterEngine
    @Binding var category: MLMathMasterGameCategory?
    
    var body: some View {
        Button(action: {
            model.gameState = .none
            category = nil
        }, label: {
            Text("New Game")
        }).buttonStyle(NeoButtonStyle(width: 300, height: 60, lightStyle: true, baseColor: .element, innerColor: .green, isBeveled: true))
        .font(Font.custom("Chalkduster", size: 30))
    }
}

struct NewGameView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameView(model: MLMathMasterEngine(), category: .constant(.add))
    }
}


