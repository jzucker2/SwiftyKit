//
//  StackingView.swift
//  Pods-SwiftyKit_Example
//
//  Created by Jordan Zucker on 8/1/17.
//

import Foundation
import UIKit

public protocol Screen {
    var bounds: CGRect { get }
}

extension UIScreen: Screen {
    
}

public struct StackViewOptions {
    let axis: UILayoutConstraintAxis/* = .vertical*/
    let alignment: UIStackViewAlignment/* = .fill*/
    let distribution: UIStackViewDistribution/* = .fill*/
    let backgroundColor: UIColor
    
    static func defaultOptions() -> StackViewOptions {
        return StackViewOptions(axis: .vertical, alignment: .fill, distribution: .fill, backgroundColor: .white)
    }
    
}

public protocol StackingView: NSObjectProtocol {
    
    var stackView: UIStackView { get }
    
    func loadedView(with options: StackViewOptions, and screen: Screen) -> UIView
    
    static var stackViewOptions: StackViewOptions { get }
    
}

extension StackingView {
    
    public static var stackViewOptions: StackViewOptions {
        return StackViewOptions.defaultOptions()
    }
    
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func stackedView(with options: StackViewOptions, and bounds: CGRect) -> UIView {
        let stackingView = UIView(frame: bounds)
        stackingView.backgroundColor = options.backgroundColor
        stackView.axis = options.axis
        stackView.alignment = options.alignment
        stackView.distribution = options.distribution
        stackingView.addSubview(stackView)
        stackView.sizeAndCenter(with: stackingView)
        return stackingView
    }
    
    public func loadedView(with options: StackViewOptions = Self.stackViewOptions, and screen: Screen = UIScreen.main) -> UIView {
        return stackedView(with: options, and: screen.bounds)
    }
    
}
