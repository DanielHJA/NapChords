//
//  ChordCollectionViewCell.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-15.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class ChordCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let temp = UIImageView(image: nil)
        temp.contentMode = .scaleAspectFit
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
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
        backgroundColor = UIColor.white
    }
    
    func setupWith(_ item: Chord) {
        imageView.kf.setImage(with: item.image)
    }
    
}
