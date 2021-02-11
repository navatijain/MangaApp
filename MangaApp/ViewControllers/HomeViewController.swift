//
//  ViewController.swift
//  MangaApp
//
//  Created by Navati Jain on 2021-02-10.
//

import UIKit

class HomeViewController: BaseViewController {
    
    private struct Constants {
        static let cellName = "CharacterTableViewCell"
        static let title = "Manga Characters"
        static let genericError = "Something went wrong! Sorry!"
    }
    
    //MARK: UI
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: Constants.cellName)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    lazy var errorScreen: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = Colors.background
        let label = UILabel()
        label.textColor = Colors.theme
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = Constants.genericError
        contentView.addSubviewWithAutoLayout(view: label)
        NSLayoutConstraint.activate(
            [label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
           label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)])
        return contentView
        
    }()
    
    private let viewModel = HomeViewModel()
    
    //MARK: Private Methods
    private func setViewModelHandler(){
        viewModel.stateChangeHandler = {[weak self] state in
            switch(state) {
            case .loaded:
                LoadingIndicator.hide()
                self?.tableView.delegate = self
                self?.tableView.dataSource = self
                self?.setTableViewConstraints()
            case .loading:
                LoadingIndicator.show()
            case .notLoaded:
                LoadingIndicator.hide()
            case .error:
                LoadingIndicator.hide()
                self?.setErrorViewConstraints()
            case .loadedMore:
                LoadingIndicator.hide()
                self?.tableView.reloadData()
                
            }
        }
    }
    private func setTableViewConstraints() {
        tableView.anchor(to: view)
    }
    
    private func setErrorViewConstraints() {
        errorScreen.anchor(to: self.view)
    }
    
    //MARK: View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewModelHandler()
        viewModel.getMangaCharacters()
        title = Constants.title
    }
}

//MARK: TableView Delegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellName) as? CharacterTableViewCell {
            cell.character = viewModel.characters[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
}

//MARK: UIScrollViewDelegate

extension HomeViewController: UIScrollViewDelegate {
    //https://www.tfzx.net/article/347570.html
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if maximumOffset - currentOffset <= 10.0 {
            viewModel.getMangaCharacters()
        }
    }
}

