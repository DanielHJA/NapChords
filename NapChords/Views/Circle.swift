//
//  Circle.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-20.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class Circle: UIView {
    
    private var shapeLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    convenience init(width: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: width, height: width))
        commonInit()
    }
    
    private func commonInit() {
        shapeLayer = CAShapeLayer()
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.width / 2, y: frame.height / 2), radius: frame.width / 2, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        shapeLayer.frame = bounds
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.strokeEnd = 0.7
        shapeLayer.lineWidth = 2.0
        
        layer.addSublayer(shapeLayer)
    }
    
}
