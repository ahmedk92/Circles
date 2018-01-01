//
//  CircularLayoutView.swift
//  ArcView
//
//  Created by Arabia -IT on 1/1/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import UIKit

@IBDesignable
class CircularLayoutView: UIView {
    
    @IBInspectable var radiusFactor: CGFloat = 1 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shift: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        guard subviews.isEmpty == false else {
            super.layoutSubviews()
            return
        }
        
        let radius = min(center.x, center.y) * radiusFactor
        let step: CGFloat = CGFloat(360 / subviews.count)
        for i in stride(from: 0, to: subviews.count, by: 1) {
            let angle = CGFloat(i) * step - shift
            let x = radius * cos(angle.degreesToRadians)
            let y = radius * sin(angle.degreesToRadians)
            
            subviews[i].translatesAutoresizingMaskIntoConstraints = false
            addConstraint(NSLayoutConstraint.init(item: subviews[i], attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: x))
            addConstraint(NSLayoutConstraint.init(item: subviews[i], attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: y))
        }
        
    }

}
