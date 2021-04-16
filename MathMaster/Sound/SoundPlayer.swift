//
//  SoundPlayer.swift
//  MathMaster
//
//  Created by Michael Lekrans on 2021-03-26.
//

import Foundation
import AVKit



class SoundPlayer: NSObject, AVAudioPlayerDelegate {
    
    var currentSong: String?
    var audioPlayer: AVAudioPlayer?
    var songs = [String]()
    var playList = [String]()
    
    override init() {
        super.init()
        
    }
    
    func play() {
        audioPlayer?.volume = 0.5
        audioPlayer?.play()
    }
    
    func stop() {
        audioPlayer?.stop()
    }
    
    func pause() {
        audioPlayer?.pause()
    }
    
    func playSong(with name: String) {
        let path = Bundle.main.path(forResource: name, ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // loop indefinitely
            play()
        } catch {
            
        }
        showProperties(for: name)
    }
    
    func addSongs(with names: [String]) {
        songs += names
        
    }
    
    func showProperties(for song: String) {
        var artist: String = ""
        var title: String = ""

        let path = Bundle.main.path(forResource: song, ofType: nil)!
        let url = URL(fileURLWithPath: path)
        let playerItem = AVPlayerItem(url: url)
        print("Duration \(playerItem.duration)")
        print("Status \(playerItem.status.rawValue)")
        print("audioPlayer duration \(self.audioPlayer?.duration)")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let ti = Int(self.audioPlayer!.duration)
            let minutes = ti / 60
            let seconds = ti % 60
            print("audioPlayer duration \(self.audioPlayer?.duration)")
            print("time \(minutes):\(seconds)")
            
        }
        print(" settings: \(audioPlayer?.settings)")
        
        let metadataList = playerItem.asset.metadata as! [AVMetadataItem]
        
        for item in metadataList {
            print("Item \(item)")
            
            guard let key = item.commonKey?.rawValue, let value = item.value else{
                continue
            }

            print("key \(key)")
           switch key {
            case "title" : title = value as? String ?? "unknown title"
            case "artist": artist = value as? String ?? "unknown artist"
//            case "artwork" where value is Data : artistImage.image = UIImage(data: value as! Data)
            default:
              continue
           }
        }
        print("artist: \(artist)")
        print("title: \(title)")
    }
    
    
    
    // MARK: - Delegate methods
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print(#function)
        // TODO: write code
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print(#function)

    }
}
