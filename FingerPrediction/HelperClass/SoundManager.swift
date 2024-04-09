//
//  SoundManager.swift
//  FingerPrediction
//
//  Created by Akash on 09/04/24.
//

import Foundation
import AVFAudio

class SoundManager {
    static let shared = SoundManager()
    var engine = AVAudioEngine()
    var playerNode = AVAudioPlayerNode()
    
    private init() {
        engine.attach(playerNode)
        engine.connect(playerNode, to: engine.mainMixerNode, format: nil)
        do {
            try engine.start()
        } catch {
            print("Error starting audio engine: \(error.localizedDescription)")
        }
    }
    
    func playWeirdSound() {
        let audioFileURL = Bundle.main.url(forResource: "Process", withExtension: "mp3")!
        let audioFile = try! AVAudioFile(forReading: audioFileURL)
        let audioFormat = audioFile.processingFormat
        let audioFrameCount = UInt32(audioFile.length)
        let audioBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: audioFrameCount)
        try! audioFile.read(into: audioBuffer!)
        playerNode.scheduleBuffer(audioBuffer!, completionHandler: nil)
        playerNode.play()
    }
    
    func stopSound() {
        playerNode.stop()
    }
}
