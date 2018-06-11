//
//  DetailViewController.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-10.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var item: ChordObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true

    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        tabBarController?.tabBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
