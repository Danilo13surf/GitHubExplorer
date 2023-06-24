//
//  BaseViewController.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController {
    // MARK: - Properties
    open var hiddenBackButton = false
    
    /// Specifies whether it is the first view controller in view code in the transition leaving the story board.
    open var shouldDismissNavigationController: Bool = false {
        willSet {
            self.shouldDismissNavigationController = newValue
            setupHeader()
        }
    }
    
    /// Specifies the text to be shown on the header label.
    open var titleText: String? = String() {
        willSet {
            self.titleText = newValue
            setupHeader()
        }
    }
    
    // MARK: - UI
    ///The `containerView` view will be the entire `view controller` respecting the safe area, and the components or views must be added directly to it.
    private let containerView = UIStackView()
    ///The `contentView` view will be the content showed in the screen dinamically
    public let contentView = UIStackView()
    
    // MARK: - Lifecycle
    open override func loadView() {
        let newView = UIView(frame: UIScreen.main.bounds)
        view = newView
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupContainerView()
        setupContentView()
        setupUI()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupConstraints()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        debugPrint("********- \(type(of: self)) \n\n")
    }
    
    // MARK: - Setup
    open func setupUI() {}
    
    private func setupContainerView() {
        view.backgroundColor = .white
        view.addSubview(containerView)
        containerView.backgroundColor = .white
        containerView.myFillSuperview()
    }
    
    private func setupContentView() {
        containerView.addSubview(contentView)
        contentView.backgroundColor = .white
    }
    
    private func setupConstraints() {
        contentView.myAnchor(
            top: (containerView.topAnchor, .zero),
            leading: (containerView.leadingAnchor, .zero),
            trailing: (containerView.trailingAnchor, .zero),
            bottom: (containerView.bottomAnchor, .zero)
        )
    }
    
    private func setupHeader() {
        self.navigationItem.title = titleText?.uppercased()
        self.navigationItem.hidesBackButton = hiddenBackButton
        if !hiddenBackButton {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: UIImage(named: GHEConstants.Constants.backButtonIcon),
                landscapeImagePhone: nil,
                style: UIBarButtonItem.Style.plain,
                target: self, action: #selector(self.btnBackAction)
            )
        }
    }
    
    // MARK: - Actions
    @objc open func btnBackAction() {
        if shouldDismissNavigationController {
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
