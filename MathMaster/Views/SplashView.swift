//
//  SplashView.swift
//  MathMaster
//
//  Created by Michael Lekrans on 2021-03-25.
//

import SwiftUI
import AVFoundation

struct SplashView: View {
    // bg
    @State private var bgOpacity: Double = 0
    
    // sans
    @State private var sansOpacity: Double = 1 // 0
    @State private var sansScale: CGFloat = 0.4
    @State private var sansRotation: Double = 0
    private var sansRotationTime: Double = 0.4
    // questionMark
    @State private var qmScale: CGFloat = 0.6
    @State private var qmOpacity: Double = 0
    
    // M1
    @State private var m1Scale: CGFloat = 0.6
    // M2
    @State private var m2Scale: CGFloat = 0.6
    // M3
    @State private var m3Scale: CGFloat = 0.6
    // M4
    @State private var m4Scale: CGFloat = 0.6
    // M5
    @State private var m5Scale: CGFloat = 0.6
    // M6
    @State private var m6Scale: CGFloat = 0.6
    
    // Master
    @State private var masterOpacity: Double = 0
    @State private var masterScale: CGFloat = 7
    @State private var mathOpacity: Double = 0
    @State private var mathScale: CGFloat = 7
    
    // ZGroup
    @State private var mainScale: CGFloat = 1.1
    
    @State private var baseWidth: CGFloat = 0
    @State private var baseHeight: CGFloat = 0
    
    @State var geometryRead: Bool = false
    
    @State var clipShapeSize: CGFloat = 900.0
    
    @State var splashDisabled = false
    
    var body: some View {
        if !geometryRead {
            
            GeometryReader { geometry in
                Color.black.onAppear() {
                    baseWidth = geometry.size.width
                    baseHeight = geometry.size.height
                    print("BaseWidth: \(baseWidth)")
                    print("BaseHeight: \(baseHeight)")
                    geometryRead = true
                }
            }
        } else {
            ZStack {
                ZStack {
                    Image("background")
                        .resizable()
                        .scaledToFill()
                        .opacity(bgOpacity)
                    
                    Image("sans")
                        .opacity(sansOpacity)
                        .scaleEffect(sansScale)
                        .rotationEffect(.degrees(sansRotation))
                        .offset(x: 0, y: 70)
                    
                    // 3 + 12
                    Image("m1")
                        .offset(x: 200, y: -120)
                        .scaleEffect(m1Scale)
                    // 5 * 3
                    Image("m2")
                        .offset(x: -120, y: -350)
                        .scaleEffect(m2Scale)
                    // 8 * 7
                    Image("m3")
                        .offset(x: -180, y: -200)
                        .scaleEffect(m3Scale)
                    // 9 / 4
                    Image("m4")
                        .offset(x: 133, y: -450)
                        .scaleEffect(m4Scale)
                    // 12 / 2
                    Image("m5")
                        .offset(x: 180, y: -250)
                        .scaleEffect(m5Scale)
                    // 12 - 12
                    Image("m6")
                        .offset(x: -150, y: -100)
                        .scaleEffect(m6Scale)
                    Image("questionMark")
                        .scaleEffect(qmScale)
                        .opacity(qmOpacity)
                        .offset(x: 0, y: -160)
                        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 8, x: 2, y: 2)
                    VStack {
                        Image("MATH")
                            .scaleEffect(mathScale * 0.8)
                            .position(x: baseWidth / 2 + 20, y: 150)
                            .opacity(mathOpacity)
                            .animation(.easeIn(duration: 0.2))
                        Image("MASTER")
                            .scaleEffect(masterScale * 0.8)
                            .position(x: baseWidth / 2 + 20, y: 150)
                            .opacity(masterOpacity)
                            .animation(.easeIn(duration: 0.2))
                        
                    }
                    .frame(width: nil, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .offset(x: 0, y: -400)
                    .scaleEffect(0.8)
                }
                .onAppear() {
                    handleAnimation()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        playSansTalk()
                    }
                }
                .frame(width: 400, height: 700, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.black)
            }
            .frame(width: clipShapeSize, height: clipShapeSize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .clipShape(
                Circle()
            )
            .allowsHitTesting(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
        }

    }
}

var sansTalk: AVAudioPlayer?

func playSansTalk() {
    let path = Bundle.main.path(forResource: "sansTalking.mp3", ofType:nil)!
    let url = URL(fileURLWithPath: path)
    
    do {
        sansTalk = try AVAudioPlayer(contentsOf: url)
        sansTalk?.play()
    } catch {
        // couldn't load file :(
    }
}




// MARK: - Extension
extension SplashView {
    func handleAnimation() {
        animateBG()
        animateSans()
        animateQuestionMark()
        animateM1Scale()
        animateM2Scale()
        animateM3Scale()
        animateM4Scale()
        animateM5Scale()
        animateM6Scale()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            mathScale = 1 * (baseWidth / 390)
            mathOpacity = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.2) {
            mainScale = 1.09
            withAnimation(.easeOut(duration: 1)) {
                mainScale = 1.1
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            masterScale = 1
            masterOpacity = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.2) {
            mainScale = 1.09
            withAnimation(.easeOut(duration: 1)) {
                mainScale = 1.1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            withAnimation(.easeInOut(duration: 1)) {
                clipShapeSize = 0.0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
                splashDisabled = true
        }
    }
    
    func animateBG() {
        withAnimation(.easeIn(duration: 1.3)) {
            bgOpacity = 1
        }
    }
    
    func animateSans() {
        withAnimation(.easeOut(duration: 1)) {
            sansScale = 0.6
        }
        withAnimation(.easeIn(duration: 2)) {
            sansOpacity = 1
        }
        animateSansRotationPhase1()
    }
    
    func animateSansRotationPhase1() {
        withAnimation(.easeInOut(duration: sansRotationTime)) {
            sansRotation = -1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + sansRotationTime) {
            animateSansRotationPhase2()
        }
    }
    
    func animateSansRotationPhase2() {
        withAnimation(.easeInOut(duration: sansRotationTime)) {
            sansRotation = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + sansRotationTime) {
            animateSansRotationPhase1()
        }
    }
    
    func animateQuestionMark() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeIn(duration: 2.0)) {
                qmOpacity = 1
            }
        }
        animateQuestionMarkPhase1()
    }
    
    func animateQuestionMarkPhase1() {
        withAnimation(.easeInOut(duration: 1)) {
            qmScale = 0.7
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            animateQuestionMarkPhase2()
        }
    }
    
    func animateQuestionMarkPhase2() {
        withAnimation(.easeInOut(duration: 1)) {
            qmScale = 0.5
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            animateQuestionMarkPhase1()
        }
    }
    
    func animateM1Scale() {
        withAnimation(.easeOut(duration: 10)) {
            m1Scale = 0.7
        }
    }
    func animateM2Scale() {
        withAnimation(.easeOut(duration: 15)) {
            m2Scale = 0.7
        }
    }
    func animateM3Scale() {
        withAnimation(.easeOut(duration: 8)) {
            m3Scale = 0.7
        }
    }
    func animateM4Scale() {
        withAnimation(.easeOut(duration: 11)) {
            m4Scale = 0.7
        }
    }
    func animateM5Scale() {
        withAnimation(.easeOut(duration: 9)) {
            m5Scale = 0.7
        }
    }
    func animateM6Scale() {
        withAnimation(.easeOut(duration: 10)) {
            m6Scale = 0.7
        }
    }
    
    
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}



//struct SplashView: View {
//    // bg
//    @State private var bgOpacity: Double = 0
//
//    // sans
//    @State private var sansOpacity: Double = 0
//    @State private var sansScale: CGFloat = 0.65
//    @State private var sansRotation: Double = 0
//    private var sansRotationTime: Double = 0.4
//    // questionMark
//    @State private var qmScale: CGFloat = 0.6
//    @State private var qmOpacity: Double = 0
//
//    // M1
//    @State private var m1Scale: CGFloat = 0.6
//    // M2
//    @State private var m2Scale: CGFloat = 0.6
//    // M3
//    @State private var m3Scale: CGFloat = 0.6
//    // M4
//    @State private var m4Scale: CGFloat = 0.6
//    // M5
//    @State private var m5Scale: CGFloat = 0.6
//    // M6
//    @State private var m6Scale: CGFloat = 0.6
//
//    // Master
//    @State private var masterOpacity: Double = 0
//    @State private var masterScale: CGFloat = 7
//    @State private var mathOpacity: Double = 0
//    @State private var mathScale: CGFloat = 7
//
//    // ZGroup
//    @State private var mainScale: CGFloat = 1.1
//
//    @State private var baseWidth: CGFloat = 0
//    @State private var baseHeight: CGFloat = 0
//
//
//    var body: some View {
//        ZStack {
//            GeometryReader { geometry in
//                ZStack {
//                    Image("background")
//                        .resizable()
//                        .scaledToFill()
//                        .opacity(bgOpacity)
//
//                    Image("sans")
//                        .opacity(sansOpacity)
//                        .scaleEffect(sansScale)
//                        .rotationEffect(.degrees(sansRotation))
//                        .offset(x: 0, y: 70)
//
//                    // 3 + 12
//                    Image("m1")
//                        .offset(x: 200, y: -120)
//                        .scaleEffect(m1Scale)
//                    // 5 * 3
//                    Image("m2")
//                        .offset(x: -120, y: -350)
//                        .scaleEffect(m2Scale)
//                    // 8 * 7
//                    Image("m3")
//                        .offset(x: -180, y: -200)
//                        .scaleEffect(m3Scale)
//                    // 9 / 4
//                    Image("m4")
//                        .offset(x: 133, y: -450)
//                        .scaleEffect(m4Scale)
//                    // 12 / 2
//                    Image("m5")
//                        .offset(x: 180, y: -250)
//                        .scaleEffect(m5Scale)
//                    // 12 - 12
//                    Image("m6")
//                        .offset(x: -150, y: -100)
//                        .scaleEffect(m6Scale)
//                    Image("questionMark")
//                        .scaleEffect(qmScale)
//                        .opacity(qmOpacity)
//                        .offset(x: 0, y: -160)
//                        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 8, x: 2, y: 2)
//                }
//                .onAppear() {
//                    handleAnimation()
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                     playSansTalk()
//                    }
//                    baseWidth = geometry.size.width
//                    baseHeight = geometry.size.height
//                    print("basewidth = \(baseWidth)")
//                    print("\(baseWidth / 390)")
//                    print("baseHeight = \(baseHeight)")
//                    print("\(baseHeight / 781.6 )")
//                }
//                .scaleEffect(mainScale)
//
//                .background(Color.black)
//                Image("MASTER")
//                    .scaleEffect(masterScale)
//                    .position(x: geometry.size.width / 2, y: 200)
//                    .opacity(masterOpacity)
//                    .animation(.easeIn(duration: 0.2))
//                Image("MATH")
//                    .scaleEffect(mathScale)
//                    .position(x: geometry.size.width / 2, y: 150)
//                    .opacity(mathOpacity)
//                    .animation(.easeIn(duration: 0.2))
//
//            }
//        }.ignoresSafeArea()
//        .scaleEffect(0.5)
//
//    }
//}
//
//var sansTalk: AVAudioPlayer?
//
//func playSansTalk() {
//    let path = Bundle.main.path(forResource: "sansTalking.mp3", ofType:nil)!
//    let url = URL(fileURLWithPath: path)
//
//    do {
//        sansTalk = try AVAudioPlayer(contentsOf: url)
//        sansTalk?.play()
//    } catch {
//        // couldn't load file :(
//    }
//}
//
//
//
//
//// MARK: - Extension
//extension SplashView {
//    func handleAnimation() {
//        animateBG()
//        animateSans()
//        animateQuestionMark()
//        animateM1Scale()
//        animateM2Scale()
//        animateM3Scale()
//        animateM4Scale()
//        animateM5Scale()
//        animateM6Scale()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            mathScale = 1
//            mathOpacity = 1
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.2) {
//            mainScale = 1.09
//            withAnimation(.easeOut(duration: 1)) {
//                mainScale = 1.1
//            }
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//            masterScale = 1
//            masterOpacity = 1
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 4.2) {
//            mainScale = 1.09
//            withAnimation(.easeOut(duration: 1)) {
//                mainScale = 1.1
//            }
//        }
//    }
//
//    func animateBG() {
//        withAnimation(.easeIn(duration: 1.3)) {
//            bgOpacity = 1
//        }
//    }
//
//    func animateSans() {
//        withAnimation(.easeOut(duration: 1)) {
//            sansScale = 0.7
//        }
//        withAnimation(.easeIn(duration: 2)) {
//            sansOpacity = 1
//        }
//        animateSansRotationPhase1()
//    }
//
//    func animateSansRotationPhase1() {
//        withAnimation(.easeInOut(duration: sansRotationTime)) {
//            sansRotation = -1
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + sansRotationTime) {
//            animateSansRotationPhase2()
//        }
//    }
//
//    func animateSansRotationPhase2() {
//        withAnimation(.easeInOut(duration: sansRotationTime)) {
//            sansRotation = 1
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + sansRotationTime) {
//            animateSansRotationPhase1()
//        }
//    }
//
//    func animateQuestionMark() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            withAnimation(.easeIn(duration: 2.0)) {
//                qmOpacity = 1
//            }
//        }
//        animateQuestionMarkPhase1()
//    }
//
//    func animateQuestionMarkPhase1() {
//        withAnimation(.easeInOut(duration: 1)) {
//            qmScale = 0.7
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            animateQuestionMarkPhase2()
//        }
//    }
//
//    func animateQuestionMarkPhase2() {
//        withAnimation(.easeInOut(duration: 1)) {
//            qmScale = 0.5
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            animateQuestionMarkPhase1()
//        }
//    }
//
//    func animateM1Scale() {
//        withAnimation(.easeOut(duration: 10)) {
//            m1Scale = 0.7
//        }
//    }
//    func animateM2Scale() {
//        withAnimation(.easeOut(duration: 15)) {
//            m2Scale = 0.7
//        }
//    }
//    func animateM3Scale() {
//        withAnimation(.easeOut(duration: 8)) {
//            m3Scale = 0.7
//        }
//    }
//    func animateM4Scale() {
//        withAnimation(.easeOut(duration: 11)) {
//            m4Scale = 0.7
//        }
//    }
//    func animateM5Scale() {
//        withAnimation(.easeOut(duration: 9)) {
//            m5Scale = 0.7
//        }
//    }
//    func animateM6Scale() {
//        withAnimation(.easeOut(duration: 10)) {
//            m6Scale = 0.7
//        }
//    }
//
//
//}
