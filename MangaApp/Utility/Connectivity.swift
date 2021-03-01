//
//  Utility.swift
//  MangaApp
//
//  Created by Navati Jain on 2021-02-28.
//

import Foundation
import Alamofire

class Connectivity {
    static var isNetworkAvailable: Bool { NetworkReachabilityManager()?.isReachable == true }
}
