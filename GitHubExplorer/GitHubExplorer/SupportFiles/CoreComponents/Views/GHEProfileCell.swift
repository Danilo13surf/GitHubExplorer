//
//  GHEProfileCell.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import UIKit

public enum GHEProfileCellStyle {
    case resume
    case completeInfo
    case showRepo
}

class GHEProfileCell: UITableViewCell {
    // MARK: - Properties
    var imageUrl: String?
    var styleCell: GHEProfileCellStyle = .resume
    
    // MARK: - UI
    private let contentAvatarView = UIView()
    private let contentLabelView = UIView()
    
    private lazy var avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.cornerRadius = GHEConstants.Constants.imageViewSize / 2
        imageView.borderColor = .black
        imageView.borderWidth = GHEConstants.Constants.avatarViewBoderWidth
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .blue
        label.numberOfLines = .zero
        return label
    }()
    
    // MARK: - Setup
    open func setup(title: String?, name: String? = nil, avatarUrl: String?, style: GHEProfileCellStyle = .resume
    ) {
        styleCell = style
        imageUrl = avatarUrl
        infoLabel.text = getInfoText()
        setTitleLabel(labelText: title)
        nameLabel.text = name
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        getAvatarUrl()
        setupContentAvatarView()
        setupLabelView()
        setupAvatarView()
        setupMoreInfoLabel()
        setupTitleLabel()
        setupMoreInfoUser()
    }
    
    private func getInfoText() -> String {
        switch styleCell {
        case .resume:
            return  GHEConstants.Constants.moreInfoText
        case .completeInfo:
            return GHEConstants.Constants.showRepositories
        case .showRepo:
            return GHEConstants.Constants.goRepositories
        }
    }
    
    private func getAvatarUrl() {
        if let imageUrlString = imageUrl, let url = URL(string: imageUrlString) {
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    print("\(GHEConstants.Constants.textDownloadError) \(error.localizedDescription)")
                    return
                }
                guard let imageData = data else {
                    print(GHEConstants.Constants.textNotFoundData)
                    return
                }
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.avatarView.image = image
                    }
                } else {
                    print(GHEConstants.Constants.texImageCorrupted)
                }
            }
            task.resume()
        }
    }
    
    private func setTitleLabel(labelText: String?) {
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: titleLabel.font.pointSize)
        ]
        let attributedTitle = NSAttributedString(string: labelText ?? String(), attributes: boldAttributes)
        titleLabel.attributedText = attributedTitle
    }
    
    private func setupContentAvatarView() {
        contentView.addSubview(contentAvatarView)
        contentAvatarView.myAnchor(
            top: (contentView.topAnchor, .zero),
            leading: (contentView.leadingAnchor, .zero),
            bottom: (contentView.bottomAnchor, 24),
            width: (128),
            height: (128))
    }
    
    private func setupLabelView() {
        contentView.addSubview(contentLabelView)
        contentLabelView.myAnchor(
            top: (contentView.topAnchor, .zero),
            leading: (contentAvatarView.trailingAnchor, .zero),
            trailing: (contentView.trailingAnchor, .zero),
            bottom: (contentView.bottomAnchor, .zero)
        )
    }
    
    private func setupAvatarView() {
        contentAvatarView.addSubview(avatarView)
        avatarView.myFillSuperview()
    }
    
    private func setupTitleLabel() {
        contentLabelView.addSubview(titleLabel)
        titleLabel.myAnchor(
            centerX: (infoLabel.centerXAnchor, .zero),
            top: (contentLabelView.topAnchor, 36)
        )
    }
    
    private func setupMoreInfoUser() {
        guard styleCell == .completeInfo else { return }
        setupNameLabel()
    }
    
    private func setupNameLabel() {
        contentLabelView.addSubview(nameLabel)
        nameLabel.myAnchor(
            centerX: (infoLabel.centerXAnchor, .zero),
            top: (titleLabel.bottomAnchor, 8),
            leading: (contentLabelView.leadingAnchor, 24),
            trailing: (contentLabelView.trailingAnchor, 24)
        )
    }
    
    private func setupMoreInfoLabel() {
        contentLabelView.addSubview(infoLabel)
        infoLabel.myAnchor(
            leading: (contentLabelView.leadingAnchor, 12),
            trailing: (contentLabelView.trailingAnchor, 24),
            bottom: (contentLabelView.bottomAnchor, 24)
        )
    }
}
