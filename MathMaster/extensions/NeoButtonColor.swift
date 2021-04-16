//
//  NeoButtonColor.swift
//  MathMaster
//
//  Created by Michael Lekrans on 2021-04-11.
//

import SwiftUI

struct NeoButtonStyle: ButtonStyle {
    let width: CGFloat
    let height: CGFloat
    let lightStyle: Bool
    var fillColor: Color {
        lightStyle ? Color.elementLight : Color.element
    }
    var isBeveled: Bool = false
    
    // method in the ButtonStyle protocol where you have access to label and isPressed
    // You have to take care of the buttonPress yourself when creating a ButtonStyle
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.2 : 1)
            .frame(width: width, height: height)
            .background(
                Group {
                    if !configuration.isPressed { /// determine if the button should looked pressed or not
                        ZStack {
                            Capsule()
                                .fill(fillColor)
                                .northWestShadow(radius: isBeveled ? 3 : 16, offset: isBeveled ? 1 : 6 )
                            if isBeveled {
                                Capsule()
                                    .inset(by: 3)
                                    .fill(fillColor)
                                    .southEastShadow(radius: 1, offset: 1)
                                
                            }
                        }
                    } else {
                        ZStack {
                            Capsule()
                                .fill(fillColor)
                                .southEastShadow(radius: isBeveled ? 3 : 3, offset: isBeveled ? 1 : 1 )
                            if isBeveled {
                                Capsule()
                                    .inset(by: 3)
                                    .fill(fillColor)
                                    .northWestShadow(radius: 1, offset: 1)
                                
                            }
                        }
                    }
                }
            )
    }
}

// MARK: - Extension Color
extension Color {
    static let hightlight = Color("Highlight")
    static let shadow = Color("Shadow")
    static let element = Color("Element")
    static let elementLight = Color("ElementLight")
}

extension View {
    func northWestShadow(radius: CGFloat = 16, offset: CGFloat = 6) -> some View {
        return self
            .shadow(color: .hightlight, radius: radius, x: -offset, y: -offset)
            .shadow(color: .shadow, radius: radius, x: offset, y: offset)
    }
    
    func southEastShadow(radius: CGFloat = 16, offset: CGFloat = 6) -> some View {
        return self
            .shadow(color: .shadow, radius: radius, x: -offset, y: -offset)
            .shadow(color: .hightlight, radius: radius, x: offset, y: offset)
    }
    
}

