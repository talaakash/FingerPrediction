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
    var scaledImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    private func setup(){
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressHandler(_:)))
        fingerImage.addGestureRecognizer(longPressGesture)
        SpeechManager.shared.speak(text: "Please put Your finger on sensor")
        scaledImage = UIImage(named: "FingerTouched")
        scaledImage = scaledImage?.scaledImage(withScale: 2)
    }
    
    deinit{
        print("HomeVC Cleared from Stack")
    }
    
    @objc func longPressHandler(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            fingerImage.image = UIImage(named: "FingerTouched")
            UIView.animate(withDuration: 1, animations: {
                self.fingerImage.layer.borderWidth = 0
                self.fingerImage.image = self.scaledImage
            }, completion: { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.22, execute: {
                    self.fingerPuttedOnSensor()
                    self.fingerImage.removeGestureRecognizer(gesture)
                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                    generator.prepare()
                    generator.impactOccurred()
                })
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
            
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
                self.showPrediction()
            })
        })
    }
    
    private func showPrediction(){
        SoundManager.shared.stopSound()
        fingerImage.removeFromSuperview()
        animatedTextView?.removeFromSuperview()
        let percentage = Int.random(in: 0...100)
        blinkingCursorLabel?.frame.size.height = 50
        blinkingCursorLabel?.frame.size.width = mainView.frame.width
        blinkingCursorLabel?.text = "\(percentage)% Notty"
    }
    
}

