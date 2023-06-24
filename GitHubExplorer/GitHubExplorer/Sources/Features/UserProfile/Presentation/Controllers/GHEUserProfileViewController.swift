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
    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        return view
    }()
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        bindElements()
    }
    
    override func setupUI() {
        super.setupUI()
        titleText = "\(Constants.userTitle) \(getUserName())"
        setupTableView()
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
    
    private func showLoadingView() {
        contentView.addSubview(loadingView)
        loadingView.myFillSuperview()
    }
    
    private func removeLoadingView() {
        loadingView.removeFromSuperview()
    }
    
    private func getUserName() -> String {
        if let login = viewModel?.model?.login {
            return login
        }
        return String()
    }
    
    private func setupTableView() {
        contentView.addSubview(tableView)
        tableView.isHidden = true
        tableView.myAnchor(
            top: (contentView.topAnchor, 38),
            leading: (contentView.leadingAnchor, 24),
            trailing: (contentView.trailingAnchor, 24),
            bottom: (contentView.bottomAnchor, 24)
        )
    }
    
    func openRepository(_ urlString: String?) {
        guard let url = URL(string: urlString ?? String()) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            viewModel?.status.value = .error
        }
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
        if indexPath.section == .zero {
            profileCell.setup(title: viewModel?.model?.login, avatarUrl: viewModel?.model?.avatar_url, style: viewModel?.isDisplayingRepository.value == true ? .showRepo : .completeInfo)
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
            if let cell = tableView.cellForRow(at: indexPath) {
                if cell is GHERepositoryCell {
                    openRepository(viewModel?.listRepository?[indexPath.row].html_url)
                }
            }
            viewModel?.isDisplayingRepository.value = true
            tableView.reloadData()
        }
    }
}
