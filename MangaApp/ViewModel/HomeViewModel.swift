//
//  HomeViewModel.swift
//  MangaApp
//
//  Created by Navati Jain on 2021-02-10.
//

import Foundation

class HomeViewModel {
    
    enum State {
        case loaded
        case loadedMore
        case loading
        case notLoaded
        case error
    }
    
    //MARK: Private variables
    private var state: State = .notLoaded {
        didSet {
            stateChangeHandler?(state)
        }
    }
    
    var currentPage = 0
    
    //MARK: Public Variables
    var stateChangeHandler: ((State) -> ())?
    var characters: [Characters] = []
    
    func getMangaCharacters(){
        currentPage += 1
        state = .loading
        Service.getCharacters(page: currentPage) { [weak self] (result) in
            DispatchQueue.main.async {
                switch (result) {
                case .success(let model):
                    self?.characters.append(contentsOf: model.characters)
                    self?.state = self?.currentPage == 1 ? .loaded : .loadedMore
                case .failure(let error):
                    print(error)
                    self?.state = .error
                }
            }
        }
    }
    
}
