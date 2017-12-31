//
//  ArcView.swift
//  ArcView
//
//  Created by Arabia -IT on 12/31/17.
//  Copyright © 2017 Arabia-IT. All rights reserved.
//

import UIKit

@IBDesignable
class ArcView: UIView {
    
    @IBInspectable var color: UIColor = .black
    @IBInspectable var stops: Int = 0
    @IBInspectable var gapFactor: CGFloat = 0
    @IBInspectable var shift: CGFloat = 0
    /**
     In degrees.
    */
    var arcs: [(startAngle: CGFloat, endAngle: CGFloat)] = [] {
        didSet {
            setNeedsDisplay()
        }
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        super.draw(rect)
        
        let innerCenter = CGPoint.init(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)
        let radius = min(innerCenter.x, innerCenter.y) * 0.9
        
        if let context = UIGraphicsGetCurrentContext() {
            context.clear(rect)
            
            context.setFillColor((self.backgroundColor ?? .clear).cgColor)
            context.fill(self.bounds)
            
            context.setStrokeColor(color.cgColor)
            
            let path = UIBezierPath()
            
            let step: CGFloat = stops > 0 ? CGFloat(360 / stops) : 0
            for angle: CGFloat in stride(from: 0, to: 360, by: step) {
                let gap = step * gapFactor
                let bezierPath = UIBezierPath.init(arcCenter: innerCenter, radius: radius, startAngle: (angle + gap - shift).degreesToRadians, endAngle: (angle + step - gap - shift).degreesToRadians, clockwise: true)
                path.append(bezierPath)
            }
            
            context.addPath(path.cgPath)
            context.strokePath()
        }
    }

}

extension CGFloat {
    var degreesToRadians: CGFloat {
        get {
            return (self * .pi) / 180
        }
    }
}
