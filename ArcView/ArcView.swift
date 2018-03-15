//
//  ArcView.swift
//  ArcView
//
//  Created by Arabia -IT on 12/31/17.
//  Copyright © 2017 Arabia-IT. All rights reserved.
//

import UIKit

class SectorsView: UIView {
    var colors: [UIColor] = []
    var radiusFactor: CGFloat = 0.8
    var barWidth: CGFloat = 100
    
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
            
            let step = (360.0 / CGFloat(colors.count))
            for i in 0..<colors.count {
                let angle = step * CGFloat(i)
                
                let point1 = CGPoint.init(x: (radius - barWidth) * cos(angle.degreesToRadians), y: (radius - barWidth) *
                    sin(angle.degreesToRadians))
                let point2 = CGPoint.init(x: (radius) * cos(angle.degreesToRadians), y: (radius) *
                    sin(angle.degreesToRadians))
                
                let point4 = CGPoint.init(x: (radius - barWidth) * cos((angle + step).degreesToRadians), y: (radius - barWidth) *
                    sin((angle + step).degreesToRadians))
                
                
                let path = UIBezierPath.init()
                path.move(to: point1.applying(.init(translationX: innerCenter.x, y: innerCenter.y)))
                path.addLine(to: point2.applying(.init(translationX: innerCenter.x, y: innerCenter.y)))
                path.addArc(withCenter: innerCenter, radius: radius, startAngle: angle.degreesToRadians, endAngle: (angle + step).degreesToRadians, clockwise: true)
                path.addLine(to: point4.applying(.init(translationX: innerCenter.x, y: innerCenter.y)))
                path.addArc(withCenter: innerCenter, radius: radius - barWidth, startAngle: (angle + step).degreesToRadians, endAngle: angle.degreesToRadians, clockwise: false)
                path.close()
                
                context.addPath(path.cgPath)
                context.setFillColor(colors[i % colors.count].cgColor)
                context.fillPath()
            }
            
        }
    }
}

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
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if !subview.isHidden && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
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
            
            let step: CGFloat = stops > 0 ? CGFloat(360 / stops) : 1
            for angle: CGFloat in stride(from: 0, to: 360, by: step) {
                let gap = step * gapFactor
                let bezierPath = UIBezierPath.init(arcCenter: innerCenter, radius: radius, startAngle: (angle + gap - shift).degreesToRadians, endAngle: (angle + step - gap - shift).degreesToRadians, clockwise: true)
                path.append(bezierPath)
            }
            
            context.setLineWidth(lineWidth)
            if dashLength > 0 {
                context.setLineDash(phase: dashPhase, lengths: [dashLength])
            }
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
