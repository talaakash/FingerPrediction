//
//  SpeechManager.swift
//  FingerPrediction
//
//  Created by Akash on 09/04/24.
//

import Foundation
import AVFAudio

class SpeechManager{
    static let shared = SpeechManager()
    private let synthesizer = AVSpeechSynthesizer()
    private init(){ }
    
    func speak(text: String){
        stop()
        let speechUtterance = AVSpeechUtterance(string: text)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechUtterance.rate = 0.5
        speechUtterance.pitchMultiplier = 1.0
        synthesizer.speak(speechUtterance)
    }
    
    private func stop(){
        synthesizer.stopSpeaking(at: .immediate)
    }
}
