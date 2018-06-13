//
//  DetailViewController.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-10.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    var item: ChordObject?
    private var isFullScreen: Bool = false
    
    private lazy var webView: WKWebView = {
        let temp = WKWebView()
        temp.allowsBackForwardNavigationGestures = false
        temp.backgroundColor = UIColor.gray
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        return temp
    }()
    
    private lazy var customView: UITextView = {
        let temp = UITextView()
        temp.textColor = UIColor.black
        temp.backgroundColor = UIColor.lightGray
        temp.text = "test text"
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        temp.heightAnchor.constraint(equalToConstant: view.bounds.size.height / 2).isActive = true
        return temp
    }()
    
    private lazy var doubleTapRecognizer: UITapGestureRecognizer = {
        let temp = UITapGestureRecognizer(target: self, action: #selector(makeFullscreen))
        temp.numberOfTapsRequired = 2
        temp.delegate = self
        return temp
    }()
    
    private lazy var webViewHeightConstraint: NSLayoutConstraint = {
        let temp = webView.heightAnchor.constraint(equalToConstant: view.bounds.size.height / 2)
        temp.isActive = true
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        guard let item = item else {
            navigationController?.popViewController(animated: true)
            return
        }
        
       // customView.text = item.body
        webView.loadHTMLString(item.bodyHTML, baseURL: nil)
        navigationController?.hidesBarsOnSwipe = false
        tabBarController?.tabBar.isHidden = true
        view.addConstraint(webViewHeightConstraint)
        webView.addGestureRecognizer(doubleTapRecognizer)
        title = item.title
    }
    
    @objc private func makeFullscreen() {
        let animator = UIViewPropertyAnimator(duration: 1.5, curve: .easeInOut)
       
        if isFullScreen {
            animator.addAnimations {
                self.webViewHeightConstraint.constant = self.view.bounds.height / 2
                self.view.layoutIfNeeded()
            }
        } else {
            animator.addAnimations {
                self.webViewHeightConstraint.constant = self.view.bounds.height
                self.view.layoutIfNeeded()
            }
        }
        
        isFullScreen = !isFullScreen
        animator.startAnimation()
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        tabBarController?.tabBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension DetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
