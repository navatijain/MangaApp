//
//  CustomButton.swift
//  MangaApp
//
//  Created by Navati Jain on 2021-02-13.
//

import UIKit

class CustomButton: UIButton {
    
    private func setButton(){
        backgroundColor = Colors.theme
        setTitleColor(Colors.white, for: .normal)
        layer.cornerRadius = 20
    }
    
    //MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
