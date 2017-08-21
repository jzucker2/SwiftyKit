//
//  ErrorViewController.swift
//  SwiftyKit_Example
//
//  Created by Jordan Zucker on 8/1/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import SwiftyKit

enum TestPromptError: PromptError {
    case test
    
    var prompt: String {
        return "Test"
    }
}

enum TestAlertControllerError: AlertControllerError {
    case test
    
    var alertTitle: String {
        return "Error"
    }
    
    var alertMessage: String {
        return "Test"
    }
    
}

enum TestError: Error {
    case promptError
    case alertControllerError
    
    var error: Error {
        switch self {
        case .alertControllerError:
            return TestAlertControllerError.test
        case .promptError:
            return TestPromptError.test
        }
    }
}


class ErrorViewController: UIViewController {
    
    let stackView: UIStackView = UIStackView(frame: .zero)
    
    override func loadView() {
        self.view = loadedView()
    }
    
    let navigationPromptButton = UIButton(type: .system)
    let alertControllerButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        edgesForExtendedLayout = []
        navigationItem.title = "Errors"
        title = "Errors"
        navigationPromptButton.setTitle("Navigation Prompt Error", for: .normal)
        alertControllerButton.setTitle("Alert Controller Error", for: .normal)
        
        navigationPromptButton.titleLabel?.textAlignment = .center
        alertControllerButton.titleLabel?.textAlignment = .center
        
        navigationPromptButton.addTarget(self, action: #selector(navigationPromptButtonPressed(sender:)), for: .touchUpInside)
        alertControllerButton.addTarget(self, action: #selector(alertControllerButtonPressed(sender:)), for: .touchUpInside)
        
        stackView.addArrangedSubview(navigationPromptButton)
        stackView.addArrangedSubview(alertControllerButton)
        
        view.setNeedsLayout()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    func throwError(of errorType: TestError) throws {
        throw errorType.error
    }
    
    // MARK: - UI Actions
    
    @objc func navigationPromptButtonPressed(sender: UIButton) {
        do {
            try throwError(of: .promptError)
        } catch let promptError as PromptError {
//            navigationItem.setPrompt(with: promptError)
            show(prompt: promptError)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    @objc func alertControllerButtonPressed(sender: UIButton) {
        do {
            try throwError(of: .alertControllerError)
        } catch let alertControllerError as AlertControllerError {
//            let alertController = UIAlertController.alertController(error: alertControllerError)
//            present(alertController, animated: true)
            show(alertController: alertControllerError)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

}

extension ErrorViewController: StackingView {
    
}
