//
//  HeaderView.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import UIKit

open class HeaderView: UIView {
    
    // MARK: - Properties
    open var title: String? {
        willSet {
            titleLabel.text = newValue
        }
    }
    
    // MARK: - UI
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = .zero
        return label
    }()
    
    // MARK: - Initialization
    
    public convenience init(
        title: String? = nil
    ) {
        self.init(frame: .zero)
        self.titleLabel.text = title
        didMoveToSuperview()
    }
    
    // MARK: - Private Methods
    private func setupTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.backgroundColor = .white
        titleLabel.myAnchor(
            centerX: (self.centerXAnchor, .zero),
            centerY: (self.centerYAnchor, .zero),
            leading: (self.leadingAnchor, 24),
            trailing: (self.trailingAnchor, 24)
        )
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.backgroundColor = .white
        setupTitleLabel()
    }
}
