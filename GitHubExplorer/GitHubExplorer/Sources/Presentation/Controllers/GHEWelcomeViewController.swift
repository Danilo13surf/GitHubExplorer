//
//  GHEWelcomeViewController.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import UIKit

class GHEWelcomeViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let welcomeText = "Bem vindo a busca de usuarios do github, toque na tela para continuar"
    }
    
    // MARK: - UI
    private let headerView = HeaderView(title: Constants.welcomeText)
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWelcomeLabel()
        setupGestureRecognizer()
    }
    
    // MARK: - Private Methods
    private func setupWelcomeLabel() {
        view.backgroundColor = .white
        view.addSubview(headerView)
        headerView.myAnchor(
            centerX: (view.centerXAnchor, .zero),
            centerY: (view.centerYAnchor, .zero),
            leading: (view.leadingAnchor, 24),
            trailing: (view.trailingAnchor, 24)
        )
    }
    
    private func setupGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(showNextFlow))
        view.addGestureRecognizer(tap)
    }
    
    @objc
    private func showNextFlow() {
        let coordinator = GHECordinator(navigationController: navigationController)
           coordinator.start()
    }
}
