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
        tableView.delegate = self
        tableView.dataSource = self
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
                self?.setConstraints()
            case .loading:
                LoadingIndicator.show()
            case .notLoaded:
                print("notLoaded")
            case .error:
                LoadingIndicator.hide()
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
        return UITableViewCell() //why
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }

}
