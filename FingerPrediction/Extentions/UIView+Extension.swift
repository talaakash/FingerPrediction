

import UIKit

//MARK: UIVIEW
extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    @IBInspectable
    var CornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.cornerRadius = 5
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    @IBInspectable
    var backgoundImage: UIImage{
        get{
            return self.backgoundImage
        }
        set{
            let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: self.frame.size))
            imageView.image = newValue
            imageView.contentMode = .scaleToFill
            self.addSubview(imageView)
            sendSubviewToBack(imageView)
        }
    }
    
    @IBInspectable
    var makeCircular: Bool{
        get{
            return false
        }
        set{
            self.layer.cornerRadius = bounds.height / 2
        }
    }
    
    @IBInspectable
    var animateShadow: Bool{
        get{
            return false
        }
        set {
            let animation = CABasicAnimation(keyPath: "shadowOpacity")
            animation.fromValue = 0.0
            animation.toValue = 1.0
            animation.duration = 0.5
            animation.autoreverses = true
            animation.repeatCount = Float.infinity
            layer.shadowColor = UIColor.white.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 0)
            layer.shadowOpacity = 1
            layer.shadowRadius = 10
            layer.add(animation, forKey: "shadowOpacityAnimation")
        }
    }
    
    func stopAnimatingShadow() {
        layer.removeAllAnimations()
    }
}
