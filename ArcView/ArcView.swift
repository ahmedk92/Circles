//
//  ArcView.swift
//  ArcView
//
//  Created by Arabia -IT on 12/31/17.
//  Copyright © 2017 Arabia-IT. All rights reserved.
//

import UIKit

protocol SectorsViewDataSource: class {
    func numberOfSectors(inSectorsView sectorsView: SectorsView) -> Int
    func sectorsView(_ sectorsView: SectorsView, fillColorForSectorAtIndex index: Int) -> CGColor
    func sectorsView(_ sectorsView: SectorsView, strokeColorForSectorAtIndex index: Int) -> CGColor
    func sectorsView(_ sectorsView: SectorsView, strokeWidthForSectorAtIndex index: Int) -> CGFloat
    func outerRadiusFactor(inSectorsView sectorsView: SectorsView) -> CGFloat
    func innerRadiusFactor(inSectorsView sectorsView: SectorsView) -> CGFloat
    func shiftAngleInDegrees(inSectorsView sectorsView: SectorsView) -> CGFloat
}

protocol SectorsViewDelegate: class {
    func sectorsView(_ sectorsView: SectorsView, didSelectSectorAtIndex index: Int)
}

class SectorsView: UIView {
    
    func reloadData() {
        setNeedsDisplay()
    }
    
    weak var dataSource: SectorsViewDataSource?
    weak var delegate: SectorsViewDelegate?
    
    private var paths: [Int: UIBezierPath] = [:]
    private lazy var tapGestureRecognizer: UITapGestureRecognizer = { [unowned self] in
        let tgr = UITapGestureRecognizer.init(target: self, action: #selector(tapped(_:)))
        return tgr
    }()
    
    @objc private func tapped(_ recognizer: UITapGestureRecognizer) {
        for (i, path) in paths {
            if path.contains(recognizer.location(in: self)) {
                delegate?.sectorsView(self, didSelectSectorAtIndex: i)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setNeedsDisplay()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        super.draw(rect)
        
        guard let dataSource = dataSource else { return }
        
        
        let innerCenter = CGPoint.init(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)
        let outerRadius = min(innerCenter.x, innerCenter.y) * dataSource.outerRadiusFactor(inSectorsView: self)
        let innerRadius = min(innerCenter.x, innerCenter.y) * dataSource.innerRadiusFactor(inSectorsView: self)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.clear(rect)
            
            context.setFillColor((self.backgroundColor ?? .clear).cgColor)
            context.fill(self.bounds)
            
            let step = (360.0 / CGFloat(dataSource.numberOfSectors(inSectorsView: self)))
            for i in 0..<dataSource.numberOfSectors(inSectorsView: self) {
                let angle = (step * CGFloat(i)) + dataSource.shiftAngleInDegrees(inSectorsView: self)
                
                let point1 = CGPoint.init(x: (innerRadius) * cos(angle.degreesToRadians), y: (innerRadius) *
                    sin(angle.degreesToRadians))
                let point2 = CGPoint.init(x: (outerRadius) * cos(angle.degreesToRadians), y: (outerRadius) *
                    sin(angle.degreesToRadians))
                
                let point4 = CGPoint.init(x: (innerRadius) * cos((angle + step).degreesToRadians), y: (innerRadius) *
                    sin((angle + step).degreesToRadians))
                
                
                let path = UIBezierPath.init()
                path.move(to: point1.applying(.init(translationX: innerCenter.x, y: innerCenter.y)))
                path.addLine(to: point2.applying(.init(translationX: innerCenter.x, y: innerCenter.y)))
                path.addArc(withCenter: innerCenter, radius: outerRadius, startAngle: angle.degreesToRadians, endAngle: (angle + step).degreesToRadians, clockwise: true)
                path.addLine(to: point4.applying(.init(translationX: innerCenter.x, y: innerCenter.y)))
                path.addArc(withCenter: innerCenter, radius: innerRadius, startAngle: (angle + step).degreesToRadians, endAngle: angle.degreesToRadians, clockwise: false)
                path.close()
                
                paths[i] = path
                
                context.addPath(path.cgPath)
                context.setFillColor(dataSource.sectorsView(self, fillColorForSectorAtIndex: i))
                context.fillPath()
                
                context.addPath(path.cgPath)
                context.setStrokeColor(dataSource.sectorsView(self, strokeColorForSectorAtIndex: i))
                context.setLineWidth(dataSource.sectorsView(self, strokeWidthForSectorAtIndex: i))
                context.strokePath()
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
