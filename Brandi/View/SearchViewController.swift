//
//  SearchViewController.swift
//  Brandi
//
//  Created by 박연배 on 2022/03/27.
//

import UIKit

final class SearchViewController: UIViewController {
    //MARK: Properties
    
    
    
    //MARK: UI
    let mainView = SearchView()
    
    
    //MARK: Method
    
    func searchControllerConfig() {
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        self.navigationItem.searchController?.searchBar.placeholder = "검색"
    }
    
    
    //MARK: LifeCycle
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchControllerConfig()
    }
}
