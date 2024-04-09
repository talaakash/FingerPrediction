//
//  ViewController.swift
//  FingerPrediction
//
//  Created by Akash on 08/04/24.
//

import UIKit
import Kingfisher

class HomeVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var fingerImage: UIImageView!
    @IBOutlet weak var fingerImageCenterY: NSLayoutConstraint!
    var animatedTextView: AnimatedTextView?
    var blinkingCursorLabel: BlinkingCursorLabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    private func setup(){
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressHandler(_:)))
        fingerImage.addGestureRecognizer(longPressGesture)
        SpeechManager.shared.speak(text: "Please put Your finger on sensor")
    }
    
    deinit{
        print("HomeVC Cleared from Stack")
    }
    
    @objc func longPressHandler(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            fingerImage.animateShadowHighlight()
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
                self.fingerPuttedOnSensor()
                self.fingerImage.removeGestureRecognizer(gesture)
                
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.prepare()
                generator.impactOccurred()
            })
            
        }
    }
    
    private func fingerPuttedOnSensor(){
        SpeechManager.shared.speak(text: "Wait a Minute we are calculating")
        SoundManager.shared.playWeirdSound()
        fingerImage.image = UIImage(named: Values.fingerPrintImages.randomElement() ?? "")
        fingerImage.layer.borderWidth = 0
        let newY = (-mainView.bounds.height / 2) + (fingerImage.bounds.height / 2) + 20
        fingerImageCenterY.constant += newY
        UIView.animate(withDuration: 0.33, animations: {
            self.mainView.layoutIfNeeded()
        }, completion: { _ in
            
            // Add Label with Blinking Cusrsor
            self.blinkingCursorLabel = BlinkingCursorLabel(frame: CGRect(x: self.fingerImage.frame.origin.x, y: self.fingerImage.frame.maxY + 50, width: self.fingerImage.frame.width, height: 30))
            self.blinkingCursorLabel?.text = "Analyzing......"
            self.mainView.addSubview(self.blinkingCursorLabel ?? BlinkingCursorLabel())
            
            // Add Animated TextView
            self.animatedTextView = AnimatedTextView(frame: CGRect(x: self.fingerImage.frame.origin.x, y: (self.blinkingCursorLabel?.frame.maxY ?? 0) + 50, width: self.fingerImage.frame.width, height: self.fingerImage.frame.height))
            self.mainView.addSubview(self.animatedTextView ?? AnimatedTextView())
        })
    }
    
}

