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
    
    @IBInspectable var color: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var stops: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var gapFactor: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var shift: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var radiusFactor: CGFloat = 1 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var lineWidth: CGFloat = 1 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var dashPhase: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var dashLength: CGFloat = 0 {
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
        let radius = min(innerCenter.x, innerCenter.y) * radiusFactor
        
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
            
            context.setLineWidth(lineWidth)
            context.setLineDash(phase: dashPhase, lengths: [dashLength])
            context.addPath(path.cgPath)
            context.strokePath()
        }
    }
    
    func callback() {
        
    }

}

extension CGFloat {
    var degreesToRadians: CGFloat {
        get {
            return (self * .pi) / 180
        }
    }
}
