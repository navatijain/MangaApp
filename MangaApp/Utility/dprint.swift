//
//  dpring.swift
//  MangaApp
//
//  Created by Navati Jain on 2021-03-13.
//

import Foundation

func dprint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEV
    items.forEach {
        Swift.print($0, separator: separator, terminator: terminator)
    }
    #endif
}
