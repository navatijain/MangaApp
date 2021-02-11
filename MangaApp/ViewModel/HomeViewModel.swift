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
    
    //MARK: Public Variables
    var stateChangeHandler: ((State) -> ())?
    var characters: [Characters] = []
    
    func getMangaCharacters(){
        state = .loading
        Service.getCharacters { [weak self] (result) in
            DispatchQueue.main.async {
                switch (result) {
                case .success(let model):
                    self?.characters.append(contentsOf: model.characters)
                    model.characters.forEach { (character) in
                        print(character.name)
                     
                    }
                    self?.state = .loaded
                case .failure(let error):
                    print(error)
                    self?.state = .error
                }
            }
        }
    }
    
}
