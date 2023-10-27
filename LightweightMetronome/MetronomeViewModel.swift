//
//  MetronomeViewModel.swift
//  LightweightMetronome
//
//  Created by Rob Kokochak on 10/27/23.
//

import Foundation
import Combine

final class ViewModel: ObservableObject {
    
    @Published var bpm = 60
    @Published var isPlaying = false
    
    private let audioEngine = AudioEngine()
    private let sampleTimer = SampleTimer()
    
    private var store: [AnyCancellable] = []
    
    private func subscribeToTimer() {
        sampleTimer.timerFired
            .sink { _ in
                self.handleTimerFired()
            }
            .store(in: &store)
    }
    
    private func handleTimerFired() {
        self.audioEngine.startPlayer()
    }
    
    init() {
        subscribeToTimer()
    }
    
    func startMetronome() {
        stopMetronome()
        if !sampleTimer.started {
            sampleTimer.start(interval: 60.0 / Double(bpm))
            isPlaying = true
        }
    }
    
    func stopMetronome() {
        if sampleTimer.started {
            sampleTimer.stop()
            isPlaying = false
        }
    }
}
