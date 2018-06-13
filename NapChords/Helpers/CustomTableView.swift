//
//  CustomTableView.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-13.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class CustomTableView: UITableView {
    
    var loading: Bool = false {
        didSet {
            loading ? startLoading() : stopLoading()
        }
    }
    
    private lazy var activityView: ActivityView = {
        let temp = ActivityView()
        temp.isLoading = true
        temp.loadingMessage = "Searching..."
        return temp
    }()

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.tableFooterView = UIView()
    }
    
    func reset() {
        self.reloadData()
        self.backgroundView = nil
    }
    
    private func startLoading() {
        self.insertSubview(activityView, at: 0)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityView.isLoading = true
    }
    
    private func stopLoading() {
        activityView.isLoading = false
        activityView.removeFromSuperview()
    }
    
    func reload() {
        self.reloadData()
    }
    
    func displayEmptyMessage(_ message: CustomError) {
        let temp = UILabel(frame: self.bounds)
        temp.text = message.description
        temp.textColor = UIColor.black
        temp.numberOfLines = 0
        temp.textAlignment = .center
        temp.font = UIFont(name: "Helvetica", size: 17.0)
        temp.sizeToFit()
        self.backgroundView = temp
    }

}
