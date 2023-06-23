//
//  UIViewAnimations.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import UIKit

public extension UIView {
    func stopAnimations() {
        self.layer.removeAllAnimations()
    }
    
    func fadeInOut(isHidden: Bool ,duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        
        if isHidden == self.isHidden { return }
        
        if isHidden {
            self.alpha = 1.0
            UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.alpha = 0.0
            }) { (completed) in
                self.isHidden = true
                completion(true)
            }
        } else {
            self.alpha = 0.0
            UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.isHidden = false
                self.alpha = 1.0
            }, completion: completion)
        }
    }
}
