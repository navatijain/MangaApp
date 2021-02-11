//
//  Service.swift
//  MangaApp
//
//  Created by Navati Jain on 2021-02-10.
//

import Foundation
import Alamofire
import AlamofireImage

enum CustomError: Error {
    case decoding
    case service
}

class Service {
    
    struct Constants {
        static let baseURL = "https://api.jikan.moe/v3/manga/1/characters"
    }
    
    static func getCharacters(handler: @escaping (Result<CharacterResponseModel,CustomError>) -> ()) {
        AF.request(Constants.baseURL,
                   method: .get)
            .responseData { (response) in
                switch (response.result) {
                case .success(let data):
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    if let model = try? decoder.decode(CharacterResponseModel.self, from: data) {
                        handler(.success(model))
                    } else {
                        handler(.failure(.decoding))
                    }
                case .failure(_):
                    handler(.failure(.service))
                }
            }
    }
    
    static func getImage(url: String, handler: @escaping (Result<Image,CustomError>) -> () ) {
        AF.request(url).responseImage { (response) in
            switch(response.result) {
            case .success(let image) :
                handler(.success(image))
            case .failure(let error):
                handler(.failure(.service))
            }
        }
    }
    
}
