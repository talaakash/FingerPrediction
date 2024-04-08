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
            if let gifURL = Bundle.main.url(forResource: newValue, withExtension: "gif") {
                let imageResource = KF.ImageResource(downloadURL: gifURL)
                self.kf.setImage(with: imageResource)
            }
        }
    }
}
