//
//  GHEViewController.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 22/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import UIKit

class GHEViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateColor()
    }
    
    private func updateColor() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .red
        self.view = view
    }
}

