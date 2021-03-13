//
//  CharacterCellTableViewCell.swift
//  MangaApp
//
//  Created by Navati Jain on 2021-02-10.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    private struct Constants {
        static let buttonText = "View website"
    }
    
    //MARK: - Properties

    private var roleString: NSAttributedString {
        NSAttributedString(string: "role", attributes: [
            .font : UIFont.systemFont(ofSize: 12)
        ])
    }
    
    var character: Characters? {
        didSet {
            nameLabel.text = character?.name
            if let characterRole = character?.role {
                roleLabel.attributedText = characterRole.italicize
            }
            characterImageView.setImage(from: character?.imageUrl)
        }
    }
    
    var onButtonClick: (() -> ())?
    
    //MARK: - UI Elements
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .purple
        return label
    }()
    
    private lazy var roleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .purple
        return label
    }()
    
    private lazy var visitWebsiteButton: UIButton = {
        let button = CustomButton()
        button.setTitle(Constants.buttonText, for: .normal)
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return button
    }()
    
    private lazy var spacer: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.background
        return view
    }()
    

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, roleLabel, spacer, visitWebsiteButton])
        stackView.spacing = 30
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: - Methods

    func setConstraints() {
        contentView.addSubviewWithAutoLayout(views: [characterImageView, stackView])
        NSLayoutConstraint.activate([
            characterImageView.heightAnchor.constraint(equalTo: characterImageView.widthAnchor, multiplier: 1.5),
            characterImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/3),
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: characterImageView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            visitWebsiteButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func buttonClick() {
        if let character = character {
            print(character.url)
            onButtonClick?()
        }
    }
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setConstraints()
        backgroundColor = Colors.background
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
