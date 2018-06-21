//
//  ChordCollectionViewCell.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-15.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class ChordCollectionViewCell: UICollectionViewCell {
    
    private lazy var viewContent: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.white
        temp.layer.cornerRadius = 15.0
        temp.isHidden = true
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        temp.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        temp.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8).isActive = true
        temp.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        return temp
    }()
    
    private lazy var imageView: UIImageView = {
        let temp = UIImageView(image: nil)
        temp.contentMode = .scaleAspectFit
        viewContent.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.centerXAnchor.constraint(equalTo: viewContent.centerXAnchor).isActive = true
        temp.centerYAnchor.constraint(equalTo: viewContent.centerYAnchor).isActive = true
        temp.heightAnchor.constraint(equalTo: viewContent.heightAnchor, multiplier: 0.8).isActive = true
        temp.widthAnchor.constraint(equalTo: viewContent.widthAnchor, multiplier: 0.8).isActive = true
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
 
    private func commonInit() {
        backgroundColor = UIColor.clear
        viewContent.isHidden = false
    }
    
    func setupWith(_ item: Chord) {
        imageView.kf.setImage(with: URL(string: item.image))
    }
    
}
