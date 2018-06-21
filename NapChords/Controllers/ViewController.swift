//
//  ViewController.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-09.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {
    
    private var searchViewController: UINavigationController {
        let temp = UINavigationController(rootViewController: SearchViewController())
        temp.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "tabbar_search"), tag: 0)
        return temp
    }
    
    private var savedViewController: UINavigationController {
        let temp = UINavigationController(rootViewController: SavedViewController())
        temp.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(named: "tabbar_saved"), tag: 1)
        return temp
    }
    
    private var settingsViewController: UINavigationController {
        let temp = UINavigationController(rootViewController: SettingsViewController())
        temp.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "tabbar_settings"), tag: 2)
        return temp
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Title"
        let tabs = [searchViewController, savedViewController, settingsViewController]
        tabBar.barTintColor = UIColor.black
        viewControllers = tabs
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

