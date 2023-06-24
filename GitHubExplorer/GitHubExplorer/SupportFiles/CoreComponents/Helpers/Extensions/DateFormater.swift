//
//  DateFormater.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 24/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import UIKit

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}
