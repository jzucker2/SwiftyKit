//
//  ValueExtensions.swift
//  PomodoroTurntableApp
//
//  Created by Jordan Zucker on 7/25/17.
//  Copyright © 2017 Stanera. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    public var formattedStringValue: String {
        let interval = Int(self)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
}
