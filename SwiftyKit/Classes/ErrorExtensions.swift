//
//  ErrorExtensions.swift
//  PomodoroTurntableApp
//
//  Created by Jordan Zucker on 7/12/17.
//  Copyright © 2017 Stanera. All rights reserved.
//

import UIKit

public protocol PresentableError: Error {
    
}

public protocol AlertControllerError: PresentableError {
    /// Title for the UIAlertController
    var alertTitle: String { get }
    var alertMessage: String { get }
}

public protocol PromptError: PresentableError {
    var prompt: String { get }
}

public extension UINavigationItem {
    
    func setPrompt(with error: PromptError, for duration: Double = 3.0) {
        setPrompt(with: error.prompt, for: duration)
    }
}

public extension UIAlertController {
    
    static func alertController(error: AlertControllerError, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let title = error.alertTitle
        let message = error.alertMessage
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        return alertController
    }
    
}

public extension UIViewController {
    
    func show(prompt error: PromptError, for duration: Double = NavigationBarPromptDefaultDuration) {
        DispatchQueue.main.async {
            self.navigationItem.setPrompt(with: error, for: duration)
        }
    }
    
    func show(alertController error: AlertControllerError, handler: ((UIAlertAction) -> Void)? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController.alertController(error: error, handler: handler)
            self.present(alertController, animated: true)
        }
    }
    
    func show(presentable error: PresentableError) {
        switch error {
        case let promptError as PromptError:
            show(prompt: promptError)
        case let alertControllerError as AlertControllerError:
            show(alertController: alertControllerError)
        default:
            print("Encountered other type of error: \(error.localizedDescription)")
        }
    }
    
}
