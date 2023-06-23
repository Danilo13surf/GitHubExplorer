//
//  Dynamic.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import Foundation

/// Dynamic class (used in view model)
open class Dynamic<T> {

    /// Bind type
    public typealias BindType = ((T) -> Void)

    // MARK: - Properties

    private var binds: [BindType] = []

    /// Dynamic raw value
    public var value: T {
        didSet {
            execBinds()
        }
    }

    // MARK: - Initialize

    /// Initializer
    ///
    /// - Parameter val: initial dynamic value
    public init(_ val: T) {
        value = val
    }

    // MARK: - Public Methods

    /// Bind value for changes
    ///
    /// - Parameters:
    ///   - skip: Should skip initial closure call
    ///   - fresh: should make a fresh bind (clear previous)
    ///   - bind: closure to execute every time value changed
    public func bind(skip: Bool = false, fresh: Bool = false, _ bind: @escaping BindType) {
        if fresh { binds = [] }
        binds.append(bind)

        if skip { return }

        bind(value)
    }

    // MARK: - Private Methods

    private func execBinds() {
        binds.forEach { [weak self] bind in
            guard let value = self?.value else { return }

            bind(value)
        }
    }
}
