//
//  BottomSheetView.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import UIKit

public class BottomSheetView: UIView {
    
    // MARK: - Constants
    private enum Constants {
        static let primaryButtonBorderWidth: CGFloat = 1
        static let viewAlpha: CGFloat = 0.7
    }
    
    // MARK: - Properties
    private var viewModel: BottomSheetViewModelProtocol?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.accessibilityIdentifier = BottomSheetViewIdentifiers.containerView.rawValue
        view.roundCorners(corners: [.topLeft, .topRight], radius: 40)
        return view
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.contentMode = .scaleAspectFill
        button.accessibilityIdentifier = BottomSheetViewIdentifiers.rigthButton.rawValue
        button.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .red
        imageView.contentMode = .scaleAspectFill
        imageView.accessibilityIdentifier = BottomSheetViewIdentifiers.iconImageView.rawValue
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.accessibilityIdentifier = BottomSheetViewIdentifiers.titleLabel.rawValue
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.accessibilityIdentifier = BottomSheetViewIdentifiers.descriptionLabel.rawValue
        return label
    }()
    
    private lazy var primaryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.cornerRadius = 12
        button.borderWidth = Constants.primaryButtonBorderWidth
        button.borderColor = .blue
        button.addTarget(self, action: #selector(primaryButtonAction), for: .touchUpInside)
        button.accessibilityIdentifier = BottomSheetViewIdentifiers.primaryButton.rawValue
        return button
    }()
    
    // MARK: - Initialize
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    public func setup(viewModel: BottomSheetViewModelProtocol?) {
        self.viewModel = viewModel
        bindElements()
    }
    
    // MARK: - Private Methods
    private func bindElements() {
        viewModel?.rightIconName.bind { [weak self] iconName in
            guard let self = self,
            let iconName = iconName else { return }
            self.rightButton.setImage(UIImage(named: iconName), for: .normal)
        }
        
        viewModel?.imageIconName.bind { [weak self] iconName in
            guard let self = self,
            let iconName = iconName else { return }
            self.iconImageView.image = UIImage(named: iconName)
        }
        
        viewModel?.title.bind { [weak self] text in
            guard let self = self else { return }
            self.titleLabel.text = text
        }
        
        viewModel?.description.bind { [weak self] text in
            guard let self = self else { return }
            self.descriptionLabel.text = text
        }
        
        viewModel?.primaryButtonName.bind { [weak self] text in
            guard let self = self else { return }
            self.primaryButton.setTitle(text, for: .normal)
        }
    }
    
    private func setupLayout() {
        setupContainerViewLayout()
        setupPrimaryButtonLayout()
        setupDescriptionLayout()
        setupTitleLabelLayout()
        setupIconImageViewLayout()
        setupRightIconLayout()
    }
    
    private func setupViewLayout() {
        self.backgroundColor = .black
        self.alpha = Constants.viewAlpha
    }
    
    private func setupContainerViewLayout() {
        addSubview(containerView)
        containerView.anchor(bottom: safeBottomAnchor)
        containerView.anchor(left: safeLeftAnchor, right: safeRightAnchor)
    }
    
    private func setupRightIconLayout() {
        containerView.addSubview(rightButton)
        rightButton.anchor(top: containerView.safeTopAnchor, bottom: iconImageView.safeTopAnchor, paddingTop: 32, paddingBottom: 48)
        rightButton.anchor(right: containerView.safeRightAnchor, paddingRight: 40)
        rightButton.anchor(width: 40, height: 40)
    }
    
    private func setupIconImageViewLayout() {
        containerView.addSubview(iconImageView)
        iconImageView.anchor(width: 36, height: 36)
        iconImageView.anchor(horizontal: containerView.safeCenterXAnchor)
        iconImageView.anchor(bottom: titleLabel.safeTopAnchor, paddingBottom: 40)
    }
    
    private func setupTitleLabelLayout() {
        containerView.addSubview(titleLabel)
        titleLabel.anchor(bottom: descriptionLabel.safeTopAnchor, paddingBottom: 16)
        titleLabel.anchor(left: descriptionLabel.safeLeftAnchor, right: descriptionLabel.safeRightAnchor)
    }
    
    private func setupDescriptionLayout() {
        containerView.addSubview(descriptionLabel)
        descriptionLabel.anchor(bottom: primaryButton.safeTopAnchor, paddingBottom: 40)
        descriptionLabel.anchor(left: containerView.safeLeftAnchor,
                                right: containerView.safeRightAnchor,
                                paddingLeft: 32,
                                paddingRight: 32)
    }
    
    private func setupPrimaryButtonLayout() {
        containerView.addSubview(primaryButton)
        primaryButton.anchor(bottom: containerView.safeBottomAnchor, paddingBottom: 40)
        primaryButton.anchor(left: containerView.safeLeftAnchor, right: containerView.safeRightAnchor, paddingLeft: 24, paddingRight: 24)
        primaryButton.anchor(height: 48)
    }
    
    @objc
    private func primaryButtonAction() {
        viewModel?.showPrimaryButtonFlow()
    }
    
    @objc
    private func rightButtonAction() {
        viewModel?.showRigthButtonFlow()
    }
}
