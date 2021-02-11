//
//  LoadingIndicator.swift
//  MangaApp
//
//  Created by Navati Jain on 2021-02-11.
//


import UIKit

class LoadingIndicator {
    private static var spinner: UIActivityIndicatorView?
    private static var style: UIActivityIndicatorView.Style = .large
    private static var baseBackColor = UIColor.black.withAlphaComponent(0.7)
    private static var baseColor = UIColor.white
    
    static func show (
        style: UIActivityIndicatorView.Style = style,
        backColor: UIColor = baseBackColor,
        baseColor: UIColor = baseColor
    ) {
        if spinner == nil, let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            let frame = UIScreen.main.bounds
            spinner = UIActivityIndicatorView(frame: frame)
            spinner?.backgroundColor = backColor
            spinner?.style = style
            spinner?.color = baseColor
            window.addSubview(spinner!)
            spinner!.startAnimating()
        }
    }
    
    static func hide() {
        if spinner != nil {
            spinner!.stopAnimating()
            spinner!.removeFromSuperview()
            spinner = nil
        }
    }
}

