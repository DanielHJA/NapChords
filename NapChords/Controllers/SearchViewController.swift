//
//  SearchViewController.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-10.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//
/*
navigationController?.barHideOnSwipeGestureRecognizer.addTarget(self, action: #selector(navBarHidden))

 private lazy var searchBarTopConstraint: NSLayoutConstraint = {
 let temp = searchBar.heightAnchor.constraint(equalToConstant: 55.0)
 temp.isActive = true
 return temp
 }()
 */

import UIKit

class SearchViewController: CustomViewController {
    
    private var items: [ChordObject] = []
    
    private lazy var activityView: ActivityView = {
        let temp = ActivityView()
        temp.isLoading = true
        temp.loadingMessage = "Searching..."
        return temp
    }()

    private lazy var tableView: UITableView = {
        let temp = UITableView()
        temp.delegate = self
        temp.dataSource = self
        temp.tableFooterView = UIView()
        temp.register(ChordsTableViewCell.self, forCellReuseIdentifier: Constants.Cells.chordsCell)
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        return temp
    }()
    
    private lazy var searchBar: UISearchBar = {
        let temp = UISearchBar()
        temp.placeholder = "Search"
        temp.returnKeyType = .search
        temp.delegate = self
        temp.isHidden = true
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.chordsCell, for: indexPath) as? ChordsTableViewCell else { return UITableViewCell() }
        
        cell.setupCellWith(items[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController()
        vc.item = items[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, text.count > 0 else { return }
        cleanTableView()
        startLoading()

        WebService.fetchChords(query: text, completion: { [weak self] (objects) in
            if objects.count < 1 {
                self?.tableView.displayEmptyMessage(.noResults)
            } else {
                self?.items = objects
                self?.tableView.reset()
            }
            self?.stopLoading()
            self?.tableView.reloadData()
        }) { (error) in
            print(error.description)
            self.tableView.reset()
            self.stopLoading()
            self.tableView.displayEmptyMessage(.error)
        }
    }
    
    private func cleanTableView() {
        items = []
        tableView.reloadData()
        tableView.reset()
    }
    
    private func startLoading() {
        tableView.insertSubview(activityView, at: 0)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
        activityView.isLoading = true
    }
    
    private func stopLoading() {
        activityView.isLoading = false
        activityView.removeFromSuperview()
    }
}
