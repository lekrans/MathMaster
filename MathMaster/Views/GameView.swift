//
//  GameView.swift
//  MathMaster
//
//  Created by Michael Lekrans on 2021-05-16.
//

import SwiftUI
import MLMathMasterEngine

struct GameView: View {
    @ObservedObject var model: MLMathMasterEngine
    @Binding var answer: String
    @Binding var keyboardText: String
    @State var evaluatedTo: String = ""

    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    Spacer()
                    Text("\(1 + (model.qm?.answeredQuestions.count ?? 0))\\\(model.qm?.gameData.noOfQuestions ?? 0)")
                        .font(Font.custom("Chalkduster", size: 20))
                        .padding([.bottom, .trailing], 10)
                        .padding(.top, -20)
                        .foregroundColor(.yellow)
                }
                Spacer()
            }
            Text(evaluatedTo).font(Font.custom("Chalkduster", size: 110))
                .foregroundColor(evaluatedTo == "V" ? .green : .red)
                .padding(.top, 50)
            VStack {
                Text(model.qm?.currentQuestion?.asString() ?? "12 + 5")
                    .font(Font.custom("Chalkduster", size: 55))
                Text(answer)
                    .font(Font.custom("Chalkduster", size: 75))
                Spacer()
                Text(keyboardText)
                    .font(Font.custom("Chalkduster", size: 30))

            }.onChange(of: answer, perform: { value in
                do {
                    guard let intAnswer = Int(answer) else {
                        print("couldnent convert answer to int")
                        return
                    }
                    let _ = try model.qm?.evaluateQuestion(answer: intAnswer)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        let success = model.qm?.currentQuestion?.result?.success ?? false
                        evaluatedTo = success ? "V" : "X"
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        do {
                            evaluatedTo = " "
                            try model.qm?.activateNextQuestion()
                            answer = ""
                        } catch {
                            print("Error: \(error), \(error.localizedDescription)")
                        }
                    }
                } catch {
                    print("Error: \(error), \(error.localizedDescription)")
                }
        })
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(model: MLMathMasterEngine(), answer: .constant("10"), keyboardText: .constant("20"))
    }
}
