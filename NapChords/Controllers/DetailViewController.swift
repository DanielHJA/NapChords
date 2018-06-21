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
    
    private lazy var rightBarButtonItem: UIBarButtonItem? = {
        if let object = self.item {
            var title: String = ""
            
            if RealmManager.exists(object.id.value!) && !object.scheduledForDeletion {
                title = "Remove"
            } else if RealmManager.exists(object.id.value!) && object.scheduledForDeletion {
                title = "Add"
            } else if !RealmManager.exists(object.id.value!) {
                title = "Add"
            }
            return UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(addOrRemoveFavourite))
        }
        
        return nil
    }()
    
    private lazy var textView: UITextView = {
        let temp = UITextView()
        temp.textColor = UIColor.black
        temp.isSelectable = false
        temp.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 90, right: 10)
        temp.addGestureRecognizer(doubleTapRecognizer)
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        return temp
    }()
    
    private lazy var doubleTapRecognizer: UITapGestureRecognizer = {
        let temp = UITapGestureRecognizer(target: self, action: #selector(makeFullscreen))
        temp.numberOfTapsRequired = 2
        temp.delegate = self
        return temp
    }()
    
    private lazy var twoFingerTapRecognizer: UITapGestureRecognizer = {
        let temp = UITapGestureRecognizer(target: self, action: #selector(loadChords))
        temp.numberOfTapsRequired = 2
        temp.numberOfTouchesRequired = 2
        temp.delegate = self
        return temp
    }()
    
    private lazy var textViewHeightConstraint: NSLayoutConstraint = {
        let temp = textView.heightAnchor.constraint(equalToConstant: view.bounds.size.height / 2)
        temp.isActive = true
        return temp
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let item = item else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        title = item.title
        navigationItem.rightBarButtonItem = rightBarButtonItem
        view.backgroundColor = UIColor.white
        navigationController?.hidesBarsOnSwipe = false
        tabBarController?.tabBar.isHidden = true
        textView.attributedText = item.body.highlightBracketedText()
        textView.scrollRectToVisible(CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), animated: false)
        textView.addGestureRecognizer(twoFingerTapRecognizer)
        view.addConstraint(textViewHeightConstraint)
    }
    
    @objc private func makeFullscreen() {
        let animator = UIViewPropertyAnimator(duration: 1.5, curve: .easeInOut)
       
        if isFullScreen {
            animator.addAnimations {
                self.textViewHeightConstraint.constant = self.view.bounds.height / 2
                self.view.layoutIfNeeded()
            }
        } else {
            animator.addAnimations {
                self.textViewHeightConstraint.constant = self.view.bounds.height
                self.view.layoutIfNeeded()
            }
        }
        
        isFullScreen = !isFullScreen
        animator.startAnimation()
    }
    
    @objc private func loadChords() {
        guard let item = item?.chords else { return }
        let vc = ChordsViewController()
        vc.items = item
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    @objc private func addOrRemoveFavourite() {
        guard let object = item else { return }
        
        if RealmManager.exists(object.id.value!) && !object.scheduledForDeletion {
        
            RealmManager.scheduleForDeletion(object, shouldDelete: true)
            rightBarButtonItem?.title = "Add"
        
        } else if RealmManager.exists(object.id.value!) && object.scheduledForDeletion {
            
            RealmManager.scheduleForDeletion(object, shouldDelete: false)
            rightBarButtonItem?.title = "Remove"
            
        } else if !RealmManager.exists(object.id.value!) {
            
            RealmManager.add(object)
            rightBarButtonItem?.title = "Remove"
       
        }
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
