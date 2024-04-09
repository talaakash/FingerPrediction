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
    var animatedTextView = AnimatedTextView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    private func setup(){
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressHandler(_:)))
        fingerImage.addGestureRecognizer(longPressGesture)
    }
    
    @objc func longPressHandler(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            fingerPuttedOnSensor()
        }
    }
    
    private func fingerPuttedOnSensor(){
        fingerImage.image = UIImage(named: "Finger1")
        fingerImage.contentMode = .scaleAspectFit
        let newY = mainView.frame.origin.y - 100
        UIView.animate(withDuration: 0.33, animations: {
            self.fingerImage.frame.origin.y = newY
            self.fingerImage.layer.borderWidth = 0
        })
        
        
    }
    
}

