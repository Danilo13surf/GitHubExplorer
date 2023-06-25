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
    
    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: GHEConstants.Constants.logoGithub)
        imageView.contentMode = .scaleAspectFit
        imageView.cornerRadius = GHEConstants.Constants.imageViewSize / 2
        imageView.borderColor = .black
        imageView.borderWidth = .zero
        return imageView
    }()
        
    // MARK: - Override Methods
    override func viewDidLoad() {
        hiddenBackButton = true
        super.viewDidLoad()
        setupLogoView()
        setupWelcomeLabel()
        setupGestureRecognizer()
    }
    
    // MARK: - Private Methods
    private func setupLogoView() {
        contentView.addSubview(logoView)
        logoView.myAnchor(
            centerX: (contentView.centerXAnchor, .zero),
            top: (contentView.topAnchor, 48),
            leading: (contentView.leadingAnchor, 24),
            trailing: (contentView.trailingAnchor, 24)
        )
    }
    
    private func setupWelcomeLabel() {
        contentView.addSubview(headerView)
        headerView.myAnchor(
            centerX: (contentView.centerXAnchor, .zero),
            top: (logoView.bottomAnchor, 36),
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
