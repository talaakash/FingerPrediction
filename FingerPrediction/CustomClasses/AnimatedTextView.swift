//
//  AnimetedTextBox.swift
//  FingerPrediction
//
//  Created by Akash on 09/04/24.
//

import Foundation
import UIKit

class AnimatedTextView: UITextView{
    
    private var animationTimer: Timer?
    private var currentIndex = 0
    private let characters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") // Define characters to shuffle
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup(){
        isUserInteractionEnabled = false
        backgroundColor = UIColor.clear
        textColor = UIColor.lightGray
        font = UIFont(name: "Faelorehn", size: 20)
        startShuffleAnimation()
    }
    
    private func startShuffleAnimation() {
        animationTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.updateText()
        }
    }
    
    private func updateText() {
        var shuffledText = ""
        for _ in 0...100 {
            shuffledText.append(characters.randomElement()!)
        }
        self.text = shuffledText
    }
}
