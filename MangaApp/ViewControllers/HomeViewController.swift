//
//  ViewController.swift
//  MangaApp
//
//  Created by Navati Jain on 2021-02-10.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewModelHandler()
        viewModel.getMangaCharacters()
        
    }
    
    private func setViewModelHandler(){
        viewModel.stateChangeHandler = {[weak self] state in
            switch(state) {
            
            case .loaded:
                print("loaded")
            case .loading:
                print("loading")
            case .notLoaded:
                print("notLoaded")
            case .error:
                print("error")
            }
        }
        
    }
    
}

