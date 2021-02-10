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
    
   private var state: State = .notLoaded {
        didSet {
            stateChangeHandler?(state)
        }
    }
    
    var stateChangeHandler: ((State) -> ())?
    
    func getMangaCharacters(){
        Service.getCharacters { (result) in
            switch (result) {
            case .success(let model):
                model.characters.forEach { (character) in
                    print(character.name)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
