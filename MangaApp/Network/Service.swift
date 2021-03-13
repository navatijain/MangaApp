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
    
    private struct Constants {
        static let baseURL = "https://api.jikan.moe/v3/manga/"
    }
    
    enum Endpoint {
        case characters(page: Int)
        
        var url: String {
            switch self {
            case .characters(let page):
                return "\(Constants.baseURL)\(page)/characters"
            }
        }
    }
    
    //MARK: - Properties
    
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.requestCachePolicy  = .returnCacheDataElseLoad
        
        let responseCacher = ResponseCacher(behavior: .modify({ (_, response) -> CachedURLResponse? in
            let userInfo = ["date": Date()]
            return CachedURLResponse(
                response: response.response,
                data: response.data,
                userInfo: userInfo,
                storagePolicy: .allowed)
        }))
        
        return Session(
            configuration: configuration,
            cachedResponseHandler: responseCacher
        )
    }()
    
    //MARK: - Methods
    
    func getCharacters(page:Int, handler: @escaping (Result<CharacterResponseModel,CustomError>) -> ()) {
        sessionManager.request(
            Endpoint.characters(page: page).url,
            method: .get
        )
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
    
    func getImage(url: String, handler: @escaping (Result<Image,CustomError>) -> () ) {
        AF.request(url).responseImage { (response) in
            switch(response.result) {
            case .success(let image):
                handler(.success(image))
            case .failure(let _):
                handler(.failure(.service))
            }
        }
    }
}
