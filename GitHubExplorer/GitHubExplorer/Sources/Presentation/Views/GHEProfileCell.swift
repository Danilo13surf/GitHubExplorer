//
//  GHEProfileCell.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import UIKit

class GHEProfileCell: UITableViewCell {
    
    // MARK: - Constants
    private enum Constants {
        static let imageNameDefault: String = "image_default"
        static let imageViewSize: CGFloat = 70
        static let avatarViewBoderWidth: CGFloat = 2
    }
    
    // MARK: - UI
    private lazy var avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.cornerRadius = Constants.imageViewSize / 2
        imageView.borderColor = .black
        imageView.borderWidth = Constants.avatarViewBoderWidth
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    // MARK: - Setup
    open func setup(title: String?, avatarUrl: String?) {
        titleLabel.text = title
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        setupAvatarView()
        setupTitleLabel()
    }
    
    private func setupAvatarView() {
        contentView.addSubview(avatarView)
        avatarView.myAnchor(top: (contentView.topAnchor, 24),
                            leading: (contentView.leadingAnchor, 24),
                            bottom: (contentView.bottomAnchor, 24)
        )
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.myAnchor(centerY: (avatarView.centerYAnchor, .zero),
                            top: (contentView.topAnchor, 24),
                            leading: (avatarView.trailingAnchor, 24),
                            trailing: (contentView.trailingAnchor, 24),
                            bottom: (contentView.bottomAnchor, 24)
        )
    }
}
