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
    }
    
    //MARK: UI
    lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: Constants.cellName)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
      //  tableView.backgroundColor = Colors.background
        return tableView
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
                self?.setConstraints()
            case .loading:
                LoadingIndicator.show()
            case .notLoaded:
                LoadingIndicator.hide()
            case .error:
                LoadingIndicator.hide()
            case .loadedMore:
                LoadingIndicator.hide()
                self?.tableView.reloadData()
           
            }
        }
    }
    
    private func setConstraints() {
        view.addSubviewWithAutoLayout(view: tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
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

