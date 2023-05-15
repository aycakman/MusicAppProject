//
//  PlayerManager.swift
//  Music-App
//
//  Created by Ayca Akman on 11.05.2023.
//

import Foundation
import AVFoundation

class MusicPlayerManager {
    static let shared = MusicPlayerManager()
    var player: AVPlayer?
    
    private init() {}
    
    func playMusic(previewUrl: String) {
        guard let url = URL.init(string: previewUrl) else { return }
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
    }
    
    func stopMusic() {
        player?.pause()
        player = nil 
    }
}
