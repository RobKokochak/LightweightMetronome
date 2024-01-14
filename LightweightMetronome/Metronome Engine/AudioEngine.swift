import Foundation
import AVFoundation


class AudioEngine: ObservableObject {
    private var audioPlayer: AVAudioPlayer? = nil
    
    private func setupPlayer() {
        guard let metSound = Bundle.main.url(forResource: "metronome1", withExtension: "mp3") else {
            fatalError("could not load met sound")
        }
        
        do {
            // uncomment these for iOS
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
//            try AVAudioSession.sharedInstance().setActive(true, options: [.notifyOthersOnDeactivation])
            
            audioPlayer = try AVAudioPlayer(contentsOf: metSound)
            audioPlayer?.numberOfLoops = 0
            audioPlayer?.prepareToPlay()
        } 
        catch {
            print("Failed to load met sound: \(error.localizedDescription)")
        }
    }
    
    init() {
        setupPlayer()
    }
    
    func startPlayer(volume: Float) {
        guard let player = audioPlayer else {
            fatalError("could not start audioPlayer")
        }

        if player.isPlaying {
            player.stop()
            player.currentTime = 0
        }
        player.volume = pow(volume, 2.25)
        player.play()
    }
}
