//
//  SampleTimer.swift
//  LightweightMetronome
//
//  Created by Rob Kokochak on 10/27/23.
//

import Foundation
import Combine

class SampleTimer: ObservableObject {
    @Published var started = false
    private var timer: DispatchSourceTimer?
    var timerFired = PassthroughSubject<Bool, Never>()

    func start(interval: TimeInterval) {
        let queue = DispatchQueue(label: "com.robk.lightweightmetronome.timer", qos: .userInteractive)
        timer = DispatchSource.makeTimerSource(flags: .strict, queue: queue)
        timer?.schedule(deadline: .now(), repeating: interval, leeway: .nanoseconds(0))
        timer?.setEventHandler {
            // Is there a better way to send a one shot event?  Sending a Bool here is just a hack to send SOMETHING.
            DispatchQueue.main.async {
                self.timerFired.send(true)
            }
        }
        timer?.resume()
        started = true
    }
    
    func stop() {
        timer?.cancel()
        started = false
    }
    
    func updateTimer(interval: TimeInterval) {
        stop()
        start(interval: interval)
    }
}
