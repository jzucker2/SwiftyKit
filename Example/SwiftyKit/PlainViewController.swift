//
//  PlainViewController.swift
//  SwiftyKit_Example
//
//  Created by Jordan Zucker on 8/1/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import SwiftyKit

class PlainViewController: UIViewController {
    
    let stackView: UIStackView = UIStackView(frame: .zero)
    
    var count = 0
    
    override func loadView() {
        self.view = loadedView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        edgesForExtendedLayout = []
        title = "Stack"
        navigationItem.title = "Stack"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add View", style: .done, target: self, action: #selector(addArrangedSubViewButtonPressed(sender:)))
        addArrangedSubview()
        addArrangedSubview()
        addArrangedSubview()
        view.setNeedsLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UI Actions
    
    func addArrangedSubview() {
        let countString = "SubView => \(count)"
        count += 1
        let label = UILabel(frame: .zero)
        label.text = countString
        stackView.addArrangedSubview(label)
        stackView.setNeedsLayout()
        view.setNeedsLayout()
    }
    
    @objc func addArrangedSubViewButtonPressed(sender: UIBarButtonItem) {
        addArrangedSubview()
    }

}

extension PlainViewController: StackingView {
    
}
