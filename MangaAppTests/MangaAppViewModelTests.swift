//
//  MangaAppTests.swift
//  MangaAppTests
//
//  Created by Navati Jain on 2021-02-13.
//

import XCTest
@testable import MangaApp

class MangaAppViewModelTests: XCTestCase {

    func testStateIsLoadedWhenResponseIsSuccess(){
        let viewModel = HomeViewModel(service: MockServiceSuccess())
        let expectation = XCTestExpectation(description: "State is Loaded")
        viewModel.getMangaCharacters()
        
        viewModel.stateChangeHandler = {state in
            switch state {
            case .loaded:
                expectation.fulfill()
                XCTAssertGreaterThan(viewModel.characters.count, 0, "Count of characters should be greater than zero")
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 3)
    }

}

extension MangaAppViewModelTests {
    class MockServiceSuccess: Service {
        override func getCharacters(
            page: Int,
            handler: @escaping (Result<CharacterResponseModel, CustomError>) -> ()
        ) {
            handler(.success(mockSuccessJSON))
        }
    }
}

extension MangaAppViewModelTests {
    static var mockSuccessJSON: CharacterResponseModel {
        CharacterResponseModel(
            requestHash: "request:manga:debf410931de1a4b2e810924e910067efe7bac89",
            requestCached: true,
            requestCacheExpiry: 76381,
            characters: [
                Characters(
                    malId: 433,
                    url: "https://myanimelist.net/character/423/Casca",
                    imageUrl: "https://cdn.myanimelist.net/images/characters/14/72697.jpg?s=507f381ee6e54d4bd2c59e6ed3b72c52",
                    name: "Casca",
                    role: "Main"
                ),
                Characters(
                    malId: 7857,
                    url: "https://myanimelist.net/character/7857/Farnese_de_Vandimion",
                    imageUrl: "https://cdn.myanimelist.net/images/characters/3/150707.jpg?s=f4c441ed0f987e1ac4bd66e2a451db48",
                    name: "de Vandimion, Farnese",
                    role: "Main"
                ),
                Characters(
                    malId: 424,
                    url: "https://myanimelist.net/character/424/Griffith",
                    imageUrl: "https://cdn.myanimelist.net/images/characters/9/326322.jpg?s=cccaa0f72e426492f92db8f04a168a20",
                    name: "Griffith",
                    role: "Main"),
            ]
        )
    }
}
