//
//  CharacterCellTableViewCell.swift
//  MangaApp
//
//  Created by Navati Jain on 2021-02-10.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    var character: Characters? {
        didSet {
            nameLabel.text = character?.name
            descriptionLabel.text = character?.role
            characterImageView.setImage(from: character?.imageUrl)
        }
    }
    
    //MARK: UI Elements
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .purple
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .purple
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel,descriptionLabel])
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    func setConstraints(){
        contentView.addSubviewWithAutoLayout(views: [characterImageView, stackView])
        NSLayoutConstraint.activate([
            characterImageView.heightAnchor.constraint(equalTo: characterImageView.widthAnchor, multiplier: 1.5),
            characterImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/3),
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            stackView.topAnchor.constraint(equalTo: characterImageView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
        ])
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
