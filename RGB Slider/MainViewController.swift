//
//  ViewController2.swift
//  RGB Slider
//
//  Created by Денис Иванов on 10.10.2019.
//  Copyright © 2019 Ivanov Denis. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var rgbValues: [CGFloat]!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        rgbValues = view.backgroundColor?.cgColor.components
    }
    
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SettingViewController {
            vc.delegate = self
            vc.rgbColorValues = rgbValues
        }
    }
}

extension MainViewController: SettingsDelegate {
    func pass(to tuple: (UIColor?, [CGFloat]?)) {
        view.backgroundColor = tuple.0
        rgbValues = tuple.1
    }
}
