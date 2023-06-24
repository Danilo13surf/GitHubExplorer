//
//  BottomSheetViewModel.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import CoreSwift
import UIKit

enum BottomSheetViewIdentifiers: String {
    case containerView = "bottomSheetView_containerView_id"
    case rigthButton = "bottomSheetView_rightButton_id"
    case titleLabel = "bottomSheetView_titleLabel_id"
    case iconImageView = "bottomSheetView_imageIconView_id"
    case descriptionLabel = "bottomSheetView_descriptionLabel_id"
    case primaryButton = "bottomSheetView_primaryButton_id"
}

public typealias BottomSheetViewFlow = () -> Void

public protocol BottomSheetViewModelProtocol: AnyObject {
    var rightIconName: Dynamic<String?> { get }
    var imageIconName: Dynamic<String?> { get }
    var title: Dynamic<String?> { get }
    var description: Dynamic<String?> { get }
    var primaryButtonName: Dynamic<String?> { get }
    
    init(model: BottomSheetModel, primaryButtonFlow: @escaping BottomSheetViewFlow, rigthButtonFlow: @escaping BottomSheetViewFlow)
    
    func setup()
    func showRigthButtonFlow()
    func showPrimaryButtonFlow()
}

public class BottomSheetViewModel: BottomSheetViewModelProtocol {
    
    // MARK: - Properties
    
    private var primaryButtonFlow: BottomSheetViewFlow
    private var rigthButtonFlow: BottomSheetViewFlow
    private var model: BottomSheetModel?
    
    public var rightIconName = Dynamic<String?>(nil)
    public var imageIconName = Dynamic<String?>(nil)
    public var title = Dynamic<String?>(nil)
    public var description = Dynamic<String?>(nil)
    public var primaryButtonName = Dynamic<String?>(nil)
    
    // MARK: - Initialize
    
    public required init(model: BottomSheetModel,
                         primaryButtonFlow: @escaping BottomSheetViewFlow,
                         rigthButtonFlow: @escaping BottomSheetViewFlow) {
        self.model = model
        self.primaryButtonFlow = primaryButtonFlow
        self.rigthButtonFlow = rigthButtonFlow
    }
    
    // MARK: - Public Methods
    
    public func setup() {
        rightIconName.value = model?.rightIconName
        imageIconName.value = model?.imageIconName
        title.value = model?.title
        description.value = model?.description
        primaryButtonName.value = model?.primaryButtonName
    }
    
    public func showRigthButtonFlow() {
        self.rigthButtonFlow()
    }
    
    public func showPrimaryButtonFlow() {
        self.primaryButtonFlow()
    }
}
