//
//  ResultView.swift
//  MathMaster
//
//  Created by Michael Lekrans on 2021-05-17.
//

import SwiftUI
import MLMathMasterEngine

struct ResultView: View {
    @ObservedObject var model: MLMathMasterEngine
    
    init(model: MLMathMasterEngine) {
        self.model = model
//        getData()
    }
    
    var body: some View {
        VStack {
            // Score
            Text("\(model.qm!.noOfRightAnswers)/\(model.qm!.answeredQuestions.count)")
                .font(Font.custom("Chalkduster", fixedSize: 80))
            // Time
            Text("TotalTime: \(model.totalTime)")
                .font(Font.custom("Chalkduster", fixedSize: 20))
            // Top List 3
            List {
                Section(header: Text("Top times")) {
                    ForEach(1..<4) {i in
                        Text("Listrow \(i)")
                            .font(Font.custom("Chalkduster", fixedSize: 14))
                        
                    }
                }.font(Font.custom("Chalkduster", fixedSize: 16))
                
            }.frame(width: nil, height: 150)
            
            
            // QuestionAnswerList
            List {
                Section(header: Text("Answers")) {
                    ForEach(model.qm!.answeredQuestions) { question in
                        HStack {
                            Text("\(question.asString())")
                            Text("= \(question.result?.expectedAnswer ?? -1) (answer: \(question.result?.answer ?? 0))" )
                            Spacer()
                            Text(question.result!.success ? "V" : "X")
                                .fontWeight(.heavy)
                                .foregroundColor(question.result!.success ? .green : .red)
                                .font(Font.custom("Chalkduster", size: 20))
                                .padding(.trailing, 10)
                                
                                
                        }
                    }
                }.font(Font.custom("Chalkduster", fixedSize: 16))

            }.environment(\.defaultMinListRowHeight, 20)
        }
    }
    
    func getData() {
        do {
            model.newGame(category: .add, type: .random(10), base: [3,4])
            
            while model.gameState != .stopped {
                print("gameState \(model.gameState)")
                try model.qm!.activateNextQuestion()
                let _ = try model.qm!.evaluateQuestion(answer: 3)
            }
        } catch {
            print("Error \(error), \(error.localizedDescription)")
        }
    }
    
}

struct ResultView_Previews: PreviewProvider {
    
    static var previews: some View {
        ResultView(model: MLMathMasterEngine())
            .preferredColorScheme(.dark)
    }
    
    
    
}
