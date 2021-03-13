//
//  UIView+Extension.swift
//  MangaApp
//
//  Created by Navati Jain on 2021-02-10.
//

import UIKit

extension UIView {
    
    func enableAutoLayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func addSubviewWithAutoLayout(view: UIView) {
        self.addSubview(view.enableAutoLayout())
    }
    
    func addSubviewWithAutoLayout(views: [UIView]) {
        views.forEach { (view) in
            self.addSubview(view.enableAutoLayout())
        }
    }
    
    func anchor(to view: UIView) {
        view.addSubviewWithAutoLayout(view: self)
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
