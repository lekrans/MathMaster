//
//  SoundPlayerView.swift
//  MathMaster
//
//  Created by Michael Lekrans on 2021-03-26.
//

import SwiftUI

struct SoundPlayerView: View {
    var soundPlayer: SoundPlayer!
    
    var body: some View {
        Text("SoundPlayerView")
            .onAppear() {
                soundPlayer.playSong(with: "ABeautifulDay-UndertaleAnimation.mp3")
            }
    }
}

struct SoundPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        SoundPlayerView(soundPlayer: SoundPlayer())
    }
}
