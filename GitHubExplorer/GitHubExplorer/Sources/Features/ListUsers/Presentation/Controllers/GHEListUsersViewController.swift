//
//  GHEListUsersViewController.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 22/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import UIKit

class GHEListUsersViewController: BaseViewController {
    // MARK: - Properties
    private var viewModel: GHEListUsersViewModelProtocol?
    
    // MARK: - UI
    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = GHEConstants.Constants.searchTitle
        searchBar.delegate = self
        return searchBar
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
                    self.searchBar.fadeInOut(isHidden: false)
                    self.tableView.fadeInOut(isHidden: false)
                    self.tableView.reloadData()
                }
            case .error:
                DispatchQueue.main.async {
                    self.showBottonSheet()
                }
            case .popToRoot:
                DispatchQueue.main.async {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
    
    override func setupUI() {
        titleText = GHEConstants.Constants.listTitle
        setupSearchBar()
        setupTableView()
    }
    
    private func setupSearchBar() {
        contentView.addSubview(searchBar)
        searchBar.isHidden = true
        searchBar.myAnchor(
            top: (contentView.topAnchor, .zero),
            leading: (contentView.leadingAnchor, .zero),
            trailing: (contentView.trailingAnchor, .zero)
        )
    }
    
    private func setupTableView() {
        contentView.addSubview(tableView)
        tableView.isHidden = true
        tableView.myAnchor(
            top: (searchBar.bottomAnchor, 38),
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
    
    private func showBottonSheet() {
        DispatchQueue.main.async {
            guard let viewModel = self.viewModel?.bottomSheetViewModel,
                  let controller = BottomSheetViewController.instantiate(viewModel: viewModel) else { return }
            controller.modalPresentationStyle = .overFullScreen
            self.navigationController?.present(controller, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource
extension GHEListUsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let filteredCount = viewModel?.filteredModel?.count {
            return filteredCount
        }
        return viewModel?.model?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model: GHEUserResponse?
        if let filteredModel = viewModel?.filteredModel {
            model = filteredModel[indexPath.row]
        } else {
            model = viewModel?.model?[indexPath.row]
        }
        let cell = tableView.dequeueReusableCell(GHEProfileCell.self, for: indexPath)
        cell.setup(title: model?.login, avatarUrl: model?.avatar_url)
        return cell
    }
}

// MARK: - UITableViewDataSource
extension GHEListUsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async { [self] in
            if let filteredModel = viewModel?.filteredModel {
                viewModel?.showMoreInfo(model: filteredModel[indexPath.row])
            } else {
                viewModel?.showMoreInfo(model: viewModel?.model?[indexPath.row])
            }
        }
    }
}

// MARK: - UISearchBarDelegate
extension GHEListUsersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.filterUsers(byLogin: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = String()
        viewModel?.clearFilter()
        searchBar.resignFirstResponder()
    }
}
