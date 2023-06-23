//
//  GHEViewController.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 22/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import UIKit

class GHEViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: GHEViewModelProtocol?
    
    // MARK: - UI
    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        return view
    }()
    
    // MARK: - Instantiate
    static func instantiate(viewModel: GHEViewModelProtocol) -> GHEViewController? {
        let viewController = GHEViewController()
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
                }
            case .error:
                DispatchQueue.main.async {
                }
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
    }
    
    private func showLoadingView() {
        view.addSubview(loadingView)
        loadingView.myFillSuperview()
    }
    
    private func removeLoadingView() {
        loadingView.removeFromSuperview()
    }
}
