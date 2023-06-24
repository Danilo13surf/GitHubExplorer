//
//  GHERepositoryCell.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 24/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import UIKit

class GHERepositoryCell: UITableViewCell {
    
    // MARK: - UI
    private lazy var repoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.textColor = .black
        return label
    }()
    
    // MARK: - Setup
    open func setup(title: String?) {
        repoLabel.text = title
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        setupRepoLabel()
    }
    
    private func setupRepoLabel() {
        contentView.addSubview(repoLabel)
        repoLabel.myAnchor(
            top: (contentView.topAnchor, 36),
            leading: (contentView.leadingAnchor, 24),
            trailing: (contentView.trailingAnchor, 24),
            bottom: (contentView.bottomAnchor, 12)
        )
    }
}
