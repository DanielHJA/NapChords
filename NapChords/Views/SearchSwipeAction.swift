//
//  SearchSwipeAction.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-14.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

enum SwipeActionType: String {
    case add = "icon_add"
    case remove = "icon_remove"
}

class SearchSwipeAction: UIContextualAction {

    var actionStyle: SwipeActionType = .add {
        didSet {
            self.backgroundColor = actionStyle == .add ? UIColor.green : UIColor.red
            self.image = UIImage(named: actionStyle.rawValue)
        }
    }
}
