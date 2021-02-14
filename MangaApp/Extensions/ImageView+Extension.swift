//
//  Image+Extension.swift
//  MangaApp
//
//  Created by Navati Jain on 2021-02-10.
//

import UIKit

extension UIImageView {
    
    func setImage(from url: String?){
        guard let url = url else { return}
            Service().getImage(url: url) { (result) in
            DispatchQueue.main.async {
                switch (result) {
                case .success(let image):
                    self.image = image
                case .failure(_):
                    //TO DO: Placeholder
                    return
                }
            }
        }
    }
}
