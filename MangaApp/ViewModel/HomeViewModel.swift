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
        case cachedResultsAvailable
        case loading
        case notLoaded
        case error
        case additionalResultsUnavailable
    }
    
    //MARK: - Init

    init(service: Service = Service()) {
        self.service = service
    }
    
    //MARK: - Properties
    
    private var state: State = .notLoaded {
        didSet {
            increasePageCountIfNeeded()
            stateChangeHandler?(state)
        }
    }
    
    private var currentPage = 1
    private let service: Service
    
    var stateChangeHandler: ((State) -> ())?
    var characters: [Characters] = []
    var isFirstPage: Bool { currentPage == 1 }
    
    //MARK: - Methods

    func getMangaCharacters() {
        state = .loading
        
        service.getCharacters(page: currentPage) { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch (result) {
                case .success(let model):
                    if self.isFirstPage, model.characters.isEmpty {
                        self.state = .error
                    }
                    self.characters.append(contentsOf: model.characters)
                    
                    self.state = self.isFirstPage ? .loaded : .loadedMore
                    
                case .failure(let error):
                    print(error)
                    self.state = self.isFirstPage ? .error : .additionalResultsUnavailable
                }
            }
        }
    }
    
    func increasePageCountIfNeeded() {
        if state == .loaded || state == .loadedMore {
            currentPage += 1
        }
    }
}
