//
//  BaseViewController.swift
//  MangaApp
//
//  Created by Navati Jain on 2021-02-11.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: - Methods

    func setNavBar() {
        navigationController?.navigationBar.barTintColor = Colors.theme
        navigationController?.navigationBar.isOpaque = true
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor : Colors.white
        ]
    }
    
    //MARK: - LifeCycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        view.backgroundColor = Colors.background
    }
}
