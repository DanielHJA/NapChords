//
//  ChordsViewController.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-15.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class ChordsViewController: UIViewController {

    var items: [Chord] = []

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let temp = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        temp.dataSource = self
        temp.delegate = self
        temp.allowsSelection = false
        temp.backgroundView?.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        temp.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        temp.register(ChordCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Cells.chordsCell)
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        return temp
    }()
    
    private lazy var doubleTapRecognizer: UITapGestureRecognizer = {
        let temp = UITapGestureRecognizer(target: self, action: #selector(close))
        temp.numberOfTouchesRequired = 2
        temp.numberOfTapsRequired = 2
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        view.addGestureRecognizer(doubleTapRecognizer)
        collectionView.reloadData()
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ChordsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cells.chordsCell, for: indexPath) as? ChordCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setupWith(items[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.9 , height: view.frame.width * 0.9)
    }
}
