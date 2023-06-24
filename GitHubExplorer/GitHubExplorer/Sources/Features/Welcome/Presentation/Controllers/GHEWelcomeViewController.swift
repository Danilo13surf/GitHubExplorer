//
//  GHEWelcomeViewController.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import UIKit

class GHEWelcomeViewController: BaseViewController {
    // MARK: - UI
    private let headerView = HeaderView(title: GHEConstants.Constants.welcomeText)
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWelcomeLabel()
        setupGestureRecognizer()
    }
    
    // MARK: - Private Methods
    private func setupWelcomeLabel() {
        contentView.addSubview(headerView)
        headerView.myAnchor(
            centerX: (contentView.centerXAnchor, .zero),
            centerY: (contentView.centerYAnchor, .zero),
            leading: (contentView.leadingAnchor, 24),
            trailing: (contentView.trailingAnchor, 24)
        )
    }
    
    private func setupGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(showNextFlow))
        contentView.addGestureRecognizer(tap)
    }
    
    @objc
    private func showNextFlow() {
        let coordinator = GHEListUserCordinator(navigationController: navigationController)
           coordinator.start()
    }
}
