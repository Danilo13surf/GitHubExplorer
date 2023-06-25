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
    
    // MARK: - Constants
    private enum Constants {
        static let imageViewSize: CGFloat = 70
        static let avatarViewBoderWidth: CGFloat = 2
    }
    
    // MARK: - UI
    private let contentAvatarView = UIView()
    private let contentLabelView = UIView()
    
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
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.textColor = .blue
        return label
    }()
    
    var imageUrl: String?
    
    // MARK: - Setup
    open func setup(title: String?, avatarUrl: String?, style: GHEProfileCellStyle = .resume
    ) {
        setTitleLabel(labelText: title)
        imageUrl = avatarUrl
        infoLabel.text = getInfoText(style: style)
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
    }
    
    private func getInfoText(style: GHEProfileCellStyle) -> String {
        switch style {
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
    
    private func setupMoreInfoLabel() {
        contentLabelView.addSubview(infoLabel)
        infoLabel.myAnchor(
            leading: (contentLabelView.leadingAnchor, 12),
            trailing: (contentLabelView.trailingAnchor, 24),
            bottom: (contentLabelView.bottomAnchor, 24)
        )
    }
}
