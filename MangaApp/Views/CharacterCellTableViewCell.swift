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
        }
    }
    
    //MARK: UI Elements
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .purple
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .purple
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel,descriptionLabel])
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    func setConstraints(){
        contentView.addSubviewWithAutoLayout(view: stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100)
        ])
    }
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
