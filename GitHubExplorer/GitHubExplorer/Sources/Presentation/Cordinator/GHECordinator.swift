//
//  GHECordinator.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import UIKit

public class GHECordinator {
    private var navigationController: UINavigationController?

    // MARK: - Initialize
    
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public Methods
    
    public func start() {
        let viewModel = GHEViewModel(showNextFlow: showNextFlow)
        guard let viewController = GHEViewController.instantiate(viewModel: viewModel) else { return }
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Private Methods
    private func showNextFlow(model: GHEListRepositoryResponse?) { }
}
