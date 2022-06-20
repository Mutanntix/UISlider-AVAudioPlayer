//
//  Song.swift
//  Lesson6
//
//  Created by Мурад Чеерчиев on 19.06.2022.
//

import Foundation
import AVFoundation

class Song {
    let name: String
    let type: String
    var player = AVAudioPlayer()
    var imageName: String?
    var albumName = ""
    var duration: String {
        get {
            let minutes = Int(player.duration / 60)
            let seconds = Int(player.duration) % 60
            return "\(minutes.description).\(seconds.description)"
        }
    }
    
    init(_ name: String, _ type: String) {
        self.name = name
        self.type = type
    }
    
    convenience init(_ name: String, _ type: String, imageName: String? = nil) {
        self.init(name, type)
        self.imageName = imageName
        
        guard let path = Bundle.main.url(forResource: name,
                                         withExtension: type)
        else { return }
        do {
            try? player = AVAudioPlayer(contentsOf: path)
        }
    }
    
    func isPlaying() -> Bool {
        return player.isPlaying
    }
    
    func getSongDurationValue() -> Float {
        return Float(player.duration)
    }
    
    func play() {
        if player.isPlaying {
            player.pause()
            return
        }
        player.prepareToPlay()
        player.play()
    }
    
    func stop() {
        player.pause()
        self.rewindSong(value: 0)
    }
    
    func rewindSong(value: Float) {
        player.currentTime = Double(value)
    }
    
    func setupVolume(to value: Float) {
        player.setVolume(value, fadeDuration: 0.2)
    }
}
