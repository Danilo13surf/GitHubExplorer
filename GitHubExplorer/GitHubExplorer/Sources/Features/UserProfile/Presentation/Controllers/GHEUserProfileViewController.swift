//
//  GHEUserProfileViewController.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import UIKit

class GHEUserProfileViewController: BaseViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let userTitle = "Usuario:"
    }
    
    // MARK: - Properties
    private var viewModel: GHEUserProfileViewModelProtocol?
    
    // MARK: - UI
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerCell(GHEProfileCell.self)
        tableView.registerCell(GHERepositoryCell.self)
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
    static func instantiate(viewModel: GHEUserProfileViewModelProtocol) -> GHEUserProfileViewController? {
        let viewController = GHEUserProfileViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    // MARK: - Override Methods
    override func setupUI() {
        super.setupUI()
        titleText = "\(Constants.userTitle) \(getUserName())"
        setupTableView()
    }
    
    // MARK: - Private Methods
    private func getUserName() -> String {
        if let login = viewModel?.model?.login {
            return login
        }
        return String()
    }
    
    private func setupTableView() {
        contentView.addSubview(tableView)
        tableView.myAnchor(top: (contentView.topAnchor, 38),
                           leading: (contentView.leadingAnchor, 24),
                           trailing: (contentView.trailingAnchor, 24),
                           bottom: (contentView.bottomAnchor, 24)
        )
    }
}

// MARK: - UITableViewDataSource
extension GHEUserProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return .zero }
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return .zero }
        if section == .zero {
            return 1
        }
        return viewModel.listRepository?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let profileCell = tableView.dequeueReusableCell(GHEProfileCell.self, for: indexPath)
        let repositoryCell = tableView.dequeueReusableCell(GHERepositoryCell.self, for: indexPath)
        if indexPath.section == .zero && viewModel?.isDisplayingRepository.value == false {
            profileCell.setup(title: viewModel?.model?.login, avatarUrl: viewModel?.model?.avatar_url, style: .completeInfo)
            return profileCell
        }
        repositoryCell.setup(title: viewModel?.listRepository?[indexPath.row].html_url)
        return repositoryCell
    }
}

// MARK: - UITableViewDataSource

extension GHEUserProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async { [self] in
            viewModel?.isDisplayingRepository.value = true
            tableView.reloadData()
        }
    }
}
