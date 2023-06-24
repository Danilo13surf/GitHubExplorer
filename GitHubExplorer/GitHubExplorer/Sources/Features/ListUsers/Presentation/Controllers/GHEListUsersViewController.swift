//
//  GHEListUsersViewController.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 22/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import UIKit

class GHEListUsersViewController: BaseViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let listTitle = "Lista de Usuarios"
    }
    
    // MARK: - Properties
    private var viewModel: GHEListUsersViewModelProtocol?
    
    // MARK: - UI
    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        return view
    }()
    
    private lazy var headerView: HeaderView = {
        let header = HeaderView()
        header.title = Constants.listTitle
        return header
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerCell(GHEProfileCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
        return tableView
    }()
    
    // MARK: - Instantiate
    static func instantiate(viewModel: GHEListUsersViewModelProtocol) -> GHEListUsersViewController? {
        let viewController = GHEListUsersViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindElements()
        viewModel?.fetchUssers()
    }
    
    // MARK: - Private Methods
    private func bindElements() {
        viewModel?.status.bind { [weak self] status in
            guard let self = self,
                  let status = status else { return }
            switch status {
            case .loading:
                DispatchQueue.main.async {
                    self.showLoadingView()
                }
            case .loaded:
                DispatchQueue.main.async {
                    self.removeLoadingView()
                    self.headerView.fadeInOut(isHidden: false)
                    self.tableView.fadeInOut(isHidden: false)
                    self.tableView.reloadData()
                }
            case .error:
                DispatchQueue.main.async {
                }
            }
        }
    }
    
    override func setupUI() {
        titleText = Constants.listTitle
        setupTableView()
    }
    
    private func setupTableView() {
        contentView.addSubview(tableView)
        tableView.isHidden = true
        tableView.myAnchor(top: (contentView.topAnchor, 38),
                           leading: (contentView.leadingAnchor, 24),
                           trailing: (contentView.trailingAnchor, 24),
                           bottom: (contentView.bottomAnchor, 24)
        )
    }
    
    private func showLoadingView() {
        contentView.addSubview(loadingView)
        loadingView.myFillSuperview()
    }
    
    private func removeLoadingView() {
        loadingView.removeFromSuperview()
    }
}

// MARK: - UITableViewDataSource
extension GHEListUsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.model?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel?.model?[indexPath.row]
        let cell = tableView.dequeueReusableCell(GHEProfileCell.self, for: indexPath)
        cell.setup(title: model?.login, avatarUrl: model?.avatar_url)
        return cell
    }
}

// MARK: - UITableViewDataSource
extension GHEListUsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async { [self] in
            viewModel?.showMoreInfo(model: viewModel?.model?[indexPath.row])
        }
    }
}
