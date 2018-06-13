//
//  CustomViewController.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-11.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     }
}
