//
//  NewDelegate.swift
//  RGB Slider
//
//  Created by Денис Иванов on 10.10.2019.
//  Copyright © 2019 Ivanov Denis. All rights reserved.
//

import UIKit

protocol SettingsDelegate {
    func pass(to tuple: (UIColor?, [CGFloat]?))
}
