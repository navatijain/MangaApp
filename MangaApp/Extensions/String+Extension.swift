//
//  String+Extension.swift
//  MangaApp
//
//  Created by Navati Jain on 2021-02-13.
//

import Foundation
import UIKit

extension String {
    var italicize: NSMutableAttributedString  {
        return NSMutableAttributedString(
            string: self,
            attributes: [
                .font: UIFont.italicSystemFont(ofSize: 12)
            ]
        )
    }
}
