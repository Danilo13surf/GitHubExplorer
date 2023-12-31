//
//  GHEUserProfileCordinator.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import UIKit

public class GHEUserProfileCordinator {
    
    // MARK: - Properties
    private var navigationController: UINavigationController?

    // MARK: - Initialize
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public Methods
    func start(model: GHEUserResponse?) {
        let viewModel = GHEUserProfileViewModel(model: model)
        guard let viewController = GHEUserProfileViewController.instantiate(viewModel: viewModel) else { return }
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Private Methods
    private func showNextFlow(model: GHEUserResponse?) {}
}
