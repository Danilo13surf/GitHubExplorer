//
//  BottomSheetModel.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import Foundation

public struct BottomSheetModel {
    var rightIconName: String?
    var imageIconName: String?
    var title: String?
    var description: String?
    var primaryButtonName: String?
    
    public init(rightIconName: String? = "icon_close",
                imageIconName: String? = "icon_warning",
                title: String? = nil,
                description: String? = nil,
                primaryButtonName: String? = nil) {
        self.rightIconName = rightIconName
        self.imageIconName = imageIconName
        self.title = title
        self.description = description
        self.primaryButtonName = primaryButtonName
    }
}
