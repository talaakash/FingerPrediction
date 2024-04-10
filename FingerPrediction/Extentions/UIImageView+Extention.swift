//
//  UIImageView+Extention.swift
//  FingerPrediction
//
//  Created by Akash on 08/04/24.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView{
    
    @IBInspectable
    var setGif: String{
        get{
            return ""
        }
        set{
            self.setGif(name: newValue)
        }
    }
    
    func setGif(name: String){
        if let gifURL = Bundle.main.url(forResource: name, withExtension: "gif") {
            let imageResource = KF.ImageResource(downloadURL: gifURL)
            self.kf.setImage(with: imageResource)
        }
    }
    
    func addSmokyAnimation() {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterPosition = CGPoint(x: bounds.midX, y: bounds.midY)
        emitterLayer.emitterSize = bounds.size
        emitterLayer.emitterShape = .circle
        
        let cell = CAEmitterCell()
        cell.birthRate = 100
        cell.lifetime = 5.0
        cell.velocity = 50
        cell.velocityRange = 50
        cell.emissionLongitude = .pi
        cell.emissionRange = .pi / 4
        cell.scale = 0.1
        cell.scaleRange = 0.3
        cell.alphaSpeed = -0.025
        
        // Define the color for the smoke effect
        cell.color = UIColor(white: 1.0, alpha: 0.3).cgColor
        cell.contents = UIImage(named: "Smoke")?.cgImage // Use any small image for particle, or set to nil
        
        emitterLayer.emitterCells = [cell]
        
        layer.addSublayer(emitterLayer)
    }
    
    func removeSmokyAnimation(){
        self.layer.sublayers?.removeAll()
    }
    
}
