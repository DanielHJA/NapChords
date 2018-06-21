//
//  SavedViewController.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-10.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit
import RealmSwift

class SavedViewController: CustomViewController {

    private var items: Results<ChordObject> = {
        return RealmManager.returnAll()
    }()
    
    private lazy var tableView: CustomTableView = {
        let temp = CustomTableView(frame: CGRect.zero, style: .plain)
        temp.delegate = self
        temp.dataSource = self
        temp.register(ChordsTableViewCell.self, forCellReuseIdentifier: Constants.Cells.searchCell)
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if items.count < 1 {
            tableView.displayEmptyMessage(.noFavourites)
        } else {
            tableView.reset()
            tableView.reloadData()
        }
    }
    
    private func addOrRemoveObject(_ object: ChordObject) {
        if RealmManager.exists(object.id.value!) && !object.scheduledForDeletion {
            RealmManager.scheduleForDeletion(object, shouldDelete: true)
        } else if RealmManager.exists(object.id.value!) && object.scheduledForDeletion {
            RealmManager.scheduleForDeletion(object, shouldDelete: false)
        } else if !RealmManager.exists(object.id.value!) {
            RealmManager.add(object)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SavedViewController: UITableViewDataSource, UITableViewDelegate {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.searchCell, for: indexPath) as? ChordsTableViewCell else { return UITableViewCell() }
        cell.setupCellWith(items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController()
        vc.item = items[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            self.addOrRemoveObject(self.items[indexPath.row])
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
            
            if items.count < 1 {
                self.tableView.displayEmptyMessage(.noFavourites)
            }
        }
    }
}
