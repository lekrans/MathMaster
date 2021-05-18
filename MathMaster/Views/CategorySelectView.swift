//
//  CategorySelectView.swift
//  MathMaster
//
//  Created by Michael Lekrans on 2021-05-15.
//

import SwiftUI
import MLKeyboardLib
import MLMathMasterEngine

struct CategorySelectView: View {
    var height: CGFloat = 80
    var width: CGFloat = 150
    
    @ObservedObject var model: MLMathMasterEngine
    @Binding var category: MLMathMasterGameCategory?
    
    var body: some View {
        VStack {
            HStack {
                // add
                Button(action: {
                    setCategory(category: .add)
                }, label: {
                    Image(systemName: "plus.square.fill")
                        .CategoryImageIconModifier()
                }).padding([.leading, .bottom], 10)
                
                
                // subtract
                Button(action:  {
                    setCategory(category: .subtract)
                }, label: {
                    Image(systemName: "minus.square.fill")
                        .CategoryImageIconModifier()

                }).padding([.trailing, .bottom], 10)
            
            }
            
            HStack {
                // multiply
                Button(action: {
                    setCategory(category: .multiply)
                }, label: {
                    Image(systemName: "multiply.square.fill")
                        .CategoryImageIconModifier()
                }).padding(.leading, 10)
                
                // divider
                Button(action: {
                    setCategory(category: .divide)
                }, label: {
                    Image(systemName: "divide.square.fill")
                        .CategoryImageIconModifier()

                }).padding(.trailing, 10)
            
            }
            
            // Random
            Button(action:  {
                setCategory(category: .random)
            }, label: {
                HStack {
                    Image(systemName: "minus.square.fill")
                        .CategoryImageIconModifier()
                        
                    Text("Random")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(Color(hue: 0.37, saturation: 0.36, brightness: 0.577))
                        
                        
                }

            }).padding([.trailing, .bottom, .top], 10)
            .buttonStyle(NeoButtonStyle(width: 2 * width, height: height, lightStyle: true, baseColor: Color.element, innerColor: Color.green, isBeveled: true) )
        
        }
        .buttonStyle(NeoButtonStyle(width: width, height: height, lightStyle: true, baseColor: Color.element, innerColor: Color.green, isBeveled: true) )
    }
    
    func setCategory(category: MLMathMasterGameCategory) {
        self.category = category
        print("setting category to \(self.category)")
    }
    
    
}

struct CategorySelectView_Previews: PreviewProvider {
    @State var category: MLMathMasterGameCategory = .add
    static var previews: some View {
        CategorySelectView(model: MLMathMasterEngine(), category: .constant(.add))
    }
}


extension Image {
    func CategoryImageIconModifier() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.green).saturation(0.4)
            .padding()
            .opacity(0.7)
    }
}
