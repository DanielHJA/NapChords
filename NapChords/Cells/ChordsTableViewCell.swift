//
//  ChordsTableViewCell.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-10.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class ChordsTableViewCell: UITableViewCell {

    private lazy var authorLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont(name: "Helvetica", size: 20.0)
        temp.textColor = UIColor.black
        temp.textAlignment = .left
        temp.numberOfLines = 1
        temp.lineBreakMode = .byTruncatingTail
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: topAnchor, constant: 5.0).isActive = true
        temp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5.0).isActive = true
        temp.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        temp.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        return temp
    }()
    
    private lazy var songLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont(name: "Helvetica", size: 17.0)
        temp.textColor = UIColor.black
        temp.textAlignment = .left
        temp.numberOfLines = 1
        temp.lineBreakMode = .byTruncatingTail
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 5.0).isActive = true
        temp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5.0).isActive = true
        temp.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        return temp
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCellWith(_ object: ChordObject) {
        if let author = object.authors.first?.name {
            authorLabel.text = author.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        songLabel.text = object.title
    }

}
