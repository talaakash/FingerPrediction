//
//  BlinkingCursorUILabel.swift
//  FingerPrediction
//
//  Created by Akash on 09/04/24.
//

import Foundation
import UIKit

class BlinkingCursorLabel: UILabel {
    private var cursorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private var isCursorVisible = false
    private var cursorTimer: Timer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCursor()
        startBlinking()
    }
    
    private func setupCursor() {
        cursorView.removeFromSuperview()
        textColor = UIColor.lightGray
        font = UIFont(name: "Faelorehn", size: 40)
        addSubview(cursorView)
        cursorView.frame = CGRect(x: textWidth(), y: 0, width: 5, height: frame.height)
    }
    
    private func textWidth() -> CGFloat {
        guard let text = text else { return 0 }
        let attributes: [NSAttributedString.Key: Any] = [.font: font as Any]
        let textSize = (text as NSString).size(withAttributes: attributes)
        return textSize.width
    }
    
    private func startBlinking() {
        cursorTimer?.invalidate()
        cursorTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.isCursorVisible.toggle()
            self?.cursorView.isHidden = !self!.isCursorVisible
        }
    }
    
    func stopBlinking(){
        cursorView.removeFromSuperview()
    }
}
