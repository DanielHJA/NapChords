//
//  ActivityView2.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-20.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class ActivityView2: UIView {
    
    var loadingMessage: String = "" {
        didSet {
            loadingLabel.text = loadingMessage
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            loading(isLoading)
        }
    }
    
    private let rotationKey: String = "rotationKey"
    
    private lazy var loadingLabel: UILabel = {
        let temp = UILabel()
        temp.textColor = UIColor.black
        temp.text = "Loading..."
        temp.textAlignment = .center
        temp.font = UIFont(name: "Helvetica", size: 17.0)
        temp.adjustsFontSizeToFitWidth = true
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        temp.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        temp.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        return temp
    }()
    
    private lazy var indicator: Circle = {
        let size = frame.height * 0.4
        let temp = Circle(width: size)
        temp.isHidden = true
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.heightAnchor.constraint(equalToConstant: size).isActive = true
        temp.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        temp.widthAnchor.constraint(equalToConstant: size).isActive = true
        temp.bottomAnchor.constraint(equalTo: loadingLabel.topAnchor, constant: -10.0).isActive = true
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    convenience init(width: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: width, height: 50.0))
        commonInit()
    }
    
    private func commonInit() {
        indicator.isHidden = false
    }
    
    private func startAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.duration = 3.0
        animation.toValue = Double.pi * 2
        animation.repeatCount = .infinity
        indicator.layer.add(animation, forKey: rotationKey)
    }
    
    private func stopAnimation() {
        indicator.layer.removeAllAnimations()
    }
    
    private func loading(_ isLoading: Bool) {
        if isLoading {
            startAnimation()
        } else {
            stopAnimation()
        }
        
        indicator.isHidden = !isLoading
    }
    
}
