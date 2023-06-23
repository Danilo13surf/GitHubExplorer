//
//  UIViewConstraints.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import UIKit

public extension UIView {
    struct MyConstraint {
        public var centerX: NSLayoutConstraint? { didSet { centerX?.isActive = true } }
        public var centerY: NSLayoutConstraint? { didSet { centerY?.isActive = true } }
        public var top: NSLayoutConstraint? { didSet { top?.isActive = true } }
        public var leading: NSLayoutConstraint? { didSet { leading?.isActive = true } }
        public var trailing: NSLayoutConstraint? { didSet { trailing?.isActive = true } }
        public var left: NSLayoutConstraint? { didSet { left?.isActive = true } }
        public var right: NSLayoutConstraint? { didSet { right?.isActive = true } }
        public var bottom: NSLayoutConstraint? { didSet { bottom?.isActive = true } }
        public var width: NSLayoutConstraint? { didSet { width?.isActive = true } }
        public var height: NSLayoutConstraint? { didSet { height?.isActive = true } }
        
        func activate() {
            if let centerX = centerX { centerX.isActive = true }
            if let centerY = centerY { centerY.isActive = true }
            if let top = top { top.isActive = true }
            if let leading = leading { leading.isActive = true }
            if let trailing = trailing { trailing.isActive = true }
            if let left = left { left.isActive = true }
            if let right = right { right.isActive = true }
            if let bottom = bottom { bottom.isActive = true }
            if let width = width { width.isActive = true }
            if let height = height { height.isActive = true }
        }
    }
    
    @discardableResult
    func myAnchor(
        centerX: (anchor: NSLayoutXAxisAnchor, constant: CGFloat)? = nil,
        centerY: (anchor: NSLayoutYAxisAnchor, constant: CGFloat)? = nil,
        top: (anchor: NSLayoutYAxisAnchor, constant: CGFloat)? = nil,
        leading: (anchor: NSLayoutXAxisAnchor, constant: CGFloat)? = nil,
        trailing: (anchor: NSLayoutXAxisAnchor, constant: CGFloat)? = nil,
        left: (anchor: NSLayoutXAxisAnchor, constant: CGFloat)? = nil,
        right: (anchor: NSLayoutXAxisAnchor, constant: CGFloat)? = nil,
        bottom: (anchor: NSLayoutYAxisAnchor, constant: CGFloat)? = nil,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        anchorWidth: (anchor: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat)? = nil,
        anchorHeight: (anchor: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat)? = nil) -> MyConstraint {
            self.translatesAutoresizingMaskIntoConstraints = false
            
            var constraint = MyConstraint()
            
            if let centerX = centerX { constraint.centerX = centerXAnchor.constraint(equalTo: centerX.anchor, constant: centerX.constant) }
            if let centerY = centerY { constraint.centerY = centerYAnchor.constraint(equalTo: centerY.anchor, constant: centerY.constant) }
            if let top = top { constraint.top = topAnchor.constraint(equalTo: top.anchor, constant: top.constant) }
            if let leading = leading { constraint.leading = leadingAnchor.constraint(equalTo: leading.anchor, constant: leading.constant) }
            if let trailing = trailing { constraint.trailing = trailingAnchor.constraint(equalTo: trailing.anchor, constant: -trailing.constant) }
            if let left = left { constraint.left = leftAnchor.constraint(equalTo: left.anchor, constant: left.constant) }
            if let right = right { constraint.right = rightAnchor.constraint(equalTo: right.anchor, constant: -right.constant) }
            if let bottom = bottom { constraint.bottom = bottomAnchor.constraint(equalTo: bottom.anchor, constant: -bottom.constant) }
            
            if let width = width {
                constraint.width = widthAnchor.constraint(equalToConstant: width)
            } else if let anchorWidth = anchorWidth { constraint.width = widthAnchor.constraint(equalTo: anchorWidth.anchor, multiplier: anchorWidth.multiplier, constant: anchorWidth.constant) }
            
            if let height = height {
                constraint.height = heightAnchor.constraint(equalToConstant: height)
                
            } else if let anchorHeight = anchorHeight { constraint.height = heightAnchor.constraint(equalTo: anchorHeight.anchor, multiplier: anchorHeight.multiplier, constant: anchorHeight.constant)
            }
            
            constraint.activate()
            
            return constraint
        }
    
    @discardableResult
    func myTopToSafeArea(of view: UIView, constant: CGFloat = 0.0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant)
        topConstraint.isActive = true
        return topConstraint
    }
    
    @discardableResult
    func myFillSuperview(constant: CGFloat = 0.0) -> MyConstraint {
        var constraint = MyConstraint()
        if let superview = superview {
            constraint = myAnchor(
                top: (superview.safeAreaLayoutGuide.topAnchor, constant),
                left: (superview.safeAreaLayoutGuide.leftAnchor, constant),
                right: (superview.safeAreaLayoutGuide.rightAnchor, constant),
                bottom: (superview.safeAreaLayoutGuide.bottomAnchor, constant)
            )
        }
        return constraint
    }
    
    func getSuperviews() -> [UIView] {
        var superviews = [UIView]()
        var currentView: UIView? = superview
        
        while let safeCurrent = currentView {
            superviews.append(safeCurrent)
            currentView = safeCurrent.superview
        }
        return superviews
    }
}
