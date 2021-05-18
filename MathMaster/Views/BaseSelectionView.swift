//
//  BaseSelectionView.swift
//  MathMaster
//
//  Created by Michael Lekrans on 2021-05-16.
//

import SwiftUI

struct BaseSelectionView: View {
    @Binding var  base: [Int]
    
    @State var baseValues: [Bool] = Array(repeating: false, count: 11)
    var height: CGFloat = 25
    var body: some View {
        VStack {
            HStack {
                
                Button(action: {
                    baseValues = Array(repeating: false, count: 11)
                    updateBase()
                }, label: {
                        Text("None")
                            .setupButton(width: height * 4, height: height, selected: false)
                    })
                .buttonStyle(BorderlessButtonStyle())

                Button(action: {
                    baseValues = Array(repeating: true, count: 11)
                    updateBase()
                }, label: {
                        Text("All")
                            .setupButton(width: height * 4, height: height, selected: false)
                    })
                .buttonStyle(BorderlessButtonStyle())

                
            }
            
            HStack {
                ForEach(1..<11) { i in
                    Button(action: {
                        baseValues[i-1].toggle()
                        updateBase()
                    }, label: {
                            Text("\(i)")
                                .setupButton(width: height, height: height, selected: baseValues[i-1])
                }
                    ).padding(-3)
                .buttonStyle(BorderlessButtonStyle())
                    }
            }.padding(0)
        }.onAppear() {
            loadBase()
        }
    }
    
    func loadBase() {
        base.forEach { i in
            baseValues[i - 1] = true
        }
    }
    
    func updateBase() {
        base = []
        for (i, value) in baseValues.enumerated() {
            if value {
                base.append(i+1)
            }
        }
    }
}

struct BaseSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        BaseSelectionView(base: .constant([2]))
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

struct SetupButtonViewModifier: ViewModifier {
    let width: CGFloat
    let height: CGFloat
    let selected: Bool
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: width, minHeight: 0, maxHeight: height)
                    .font(.system(size: 14))
                    .padding(3)
                    .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 6)
                                    .fill(selected == true ? Color.hightlighter : Color.element))
    }
}


/// Then an extension to make the modifier callable directly.. this function does not need to handle the content
extension View {
    func setupButton(width: CGFloat, height: CGFloat, selected: Bool) -> some View {
        ModifiedContent(content: self, modifier: SetupButtonViewModifier(width: width, height: height, selected: selected))
    }
}
