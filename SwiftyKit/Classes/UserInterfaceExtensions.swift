//
//  UserInterfaceExtensions.swift
//  Pods
//
//  Created by Jordan Zucker on 7/27/17.
//
//

import UIKit

import Foundation
import UIKit

public let NavigationBarPromptDefaultDuration = 1.5

extension UIView {
    
    static func reuseIdentifier() -> String {
        return NSStringFromClass(self)
    }
    
}

extension UIView {
    
    func forceAutolayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func center(in view: UIView) {
        forceAutolayout()
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func size(to view: UIView) {
        forceAutolayout()
        widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0).isActive = true
    }
    
    func sizeAndCenter(with view: UIView) {
        forceAutolayout()
        size(to: view)
        center(in: view)
    }
    
}

extension UIView {
    
    func animateButtonPress(and completion: @escaping (Bool) -> (Void)) {
        let originalTransform = self.transform
        UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [.allowUserInteraction, .layoutSubviews, .allowAnimatedContent, .curveEaseInOut], animations: {
            self.transform = originalTransform.scaledBy(x: 0.75, y: 0.75)
            self.layoutIfNeeded()
        }) { (finished) in
            UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.0, options: [.allowUserInteraction, .layoutSubviews, .allowAnimatedContent, .curveEaseInOut], animations: {
                self.transform = originalTransform.scaledBy(x: 1.1, y: 1.1)
                self.layoutIfNeeded()
            }, completion: { (finished) in
                UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.0, options: [.allowUserInteraction, .layoutSubviews, .allowAnimatedContent, .curveEaseInOut], animations: {
                    self.transform = originalTransform
                    self.layoutIfNeeded()
                }, completion: { (finished) in
                    completion(finished)
                })
            })
        }
    }
    
}

public extension UINavigationItem {
    func setPrompt(with message: String, for duration: Double = NavigationBarPromptDefaultDuration) {
        assert(duration > 0.0)
        assert(duration < 10.0)
        DispatchQueue.main.async {
            self.prompt = message
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.prompt = nil
            }
        }
    }
    
}