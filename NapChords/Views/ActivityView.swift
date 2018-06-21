//
//  ActivityView.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-05-29.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class ActivityView: UIView {
    
    var isLoading: Bool = false {
        didSet {
            loading(isLoading)
        }
    }
    
    var loadingMessage: String = "" {
        didSet {
            loadingLabel.text = loadingMessage
        }
    }
    
    private lazy var indicatorView: UIActivityIndicatorView = {
        let temp = UIActivityIndicatorView()
        temp.color = UIColor.black
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.trailingAnchor.constraint(equalTo: loadingLabel.leadingAnchor, constant: -10).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        return temp
    }()
    
    private lazy var loadingLabel: UILabel = {
        let temp = UILabel()
        temp.textColor = UIColor.black
        temp.text = "Loading..."
        temp.textAlignment = .center
        temp.font = UIFont(name: "Helvetica", size: 17.0)
        temp.adjustsFontSizeToFitWidth = true
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 20.0).isActive = true
        temp.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
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
        backgroundColor = UIColor.clear
    }
    
    private func loading(_ isLoading: Bool) {
        if isLoading {
            indicatorView.startAnimating()
        } else {
            indicatorView.stopAnimating()
        }

        indicatorView.isHidden = !isLoading
    }
    
}
