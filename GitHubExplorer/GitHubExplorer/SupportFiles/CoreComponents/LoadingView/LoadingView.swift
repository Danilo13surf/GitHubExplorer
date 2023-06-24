//
//  LoadingView.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import UIKit

open class LoadingView: UIView {
    // MARK: - UI
    private let titleLabel = UILabel()
    private let spinnerView = UIView()
    private let spinner = UIActivityIndicatorView()
    
    private func setupTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.textAlignment = .center
        titleLabel.text = GHEConstants.Constants.loadingText
        titleLabel.textColor = .black
        titleLabel.myAnchor(
            top: (self.topAnchor, 70),
            leading: (self.leadingAnchor, 42),
            trailing: (self.trailingAnchor, 42)
        )
    }
    
    private func setupSpinnerView() {
        self.addSubview(spinnerView)
        spinnerView.myAnchor(
            centerX: (self.centerXAnchor, .zero),
            top: (titleLabel.bottomAnchor, 42),
            width: (32),
            height: (32)
        )
    }
    
    private func setupSpinnerSystem() {
        spinnerView.addSubview(spinner)
        spinner.color = .systemBlue
        spinner.myFillSuperview()
        animateSpinner()
    }
    
    private func animateSpinner() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            self.spinner.startAnimating()
        })
    }
    
    open func hideSpinner() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            for view in self.spinnerView.subviews {
                view.fadeInOut(isHidden: true)
                view.stopAnimations()
            }
        })
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupTitleLabel()
        setupSpinnerView()
        setupSpinnerSystem()
    }
}
