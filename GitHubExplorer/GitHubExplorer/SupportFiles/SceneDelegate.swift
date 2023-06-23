//
//  SceneDelegate.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 22/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: Properties
    var window: UIWindow?
    
    // MARK: UISceneSession Lifecycle
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let rootViewController = GHEWelcomeViewController()
        let rootNavigationController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }
}

