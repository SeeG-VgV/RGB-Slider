//
//  SettingViewController.swift
//  RGB Slider
//
//  Created by Денис Иванов on 22.09.2019.
//  Copyright © 2019 Ivanov Denis. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redSlaider: UISlider!
    @IBOutlet var greenSlaider: UISlider!
    @IBOutlet var blueSlaider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    @IBOutlet var redSliderLabel: UILabel!
    @IBOutlet var greenSliderLabel: UILabel!
    @IBOutlet var blueSliderLabel: UILabel!
    
    var delegate: SettingsDelegate!
    var rgbColorValues: [CGFloat]!
    
// MARK: - Overridden methods
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 10
        changeValue(for: redSlaider, greenSlaider, blueSlaider)
        
        setColorForView()
        
        changeValue(for: redTextField, greenTextField, blueTextField)
        changeValues(for: redSliderLabel, greenSliderLabel, blueSliderLabel)
        createToolbar(redTextField, greenTextField, blueTextField)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        rgbColorValues.insert(CGFloat(redSlaider.value), at: 0)
        rgbColorValues.insert(CGFloat(greenSlaider.value), at: 1)
        rgbColorValues.insert(CGFloat(blueSlaider.value), at: 2)
        
        // Передача значения на MainViewController
        delegate.pass(to: (colorView.backgroundColor, rgbColorValues))
    }
    
    @IBAction func rgbSlider(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            redSliderLabel.text = string(from: redSlaider)
            redTextField.text = string(from: redSlaider)
        case 1:
            greenSliderLabel.text = string(from: greenSlaider)
            greenTextField.text = string(from: greenSlaider)
        case 2:
            blueSliderLabel.text = string(from: blueSlaider)
            blueTextField.text = string(from: blueSlaider)
        default:
            break
        }
        
        setColorForView()
    }
    
    private func setColorForView() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlaider.value),
                                            green: CGFloat(greenSlaider.value),
                                            blue: CGFloat(blueSlaider.value),
                                            alpha: 1)
    }
    
    private func changeValues(for labels: UILabel...) {
        labels.forEach { label in
            switch label.tag {
            case 0:
                label.text = string(from: redSlaider)
            case 1:
                label.text = string(from: greenSlaider)
            case 2:
                label.text = string(from: blueSlaider)
            default:
                  break
            }
        }
    }
    
    private func changeValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField.tag {
            case 0:
                redTextField.text = string(from: redSlaider)
            case 1:
                greenTextField.text = string(from: greenSlaider)
            case 2:
                blueTextField.text = string(from: blueSlaider)
            default:
                break
            }
        }
    }
    
    private func changeValue(for slaiders: UISlider...) {
        slaiders.forEach { slaider in
            switch slaider.tag {
            case 0:
                slaider.value = Float(rgbColorValues[0])
            case 1:
                slaider.value = Float(rgbColorValues[1])
            case 2:
                slaider.value = Float(rgbColorValues[2])
            default:
                break
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        return String(format: "%.2f", slider.value)
    }
}

// MARK: - UITextFieldDelegate

extension SettingViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = Float(textField.text!) else {
            let alert = UIAlertController(title: "Warning",
                                          message: "Invalid data format. Please enter only fractional numbers.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true) {
                self.changeValue(for: self.redTextField, self.greenTextField, self.blueTextField)
            }
            
            return
            
        }
        
        switch textField.tag {
        case 0:
            redSlaider.value = text
            redSliderLabel.text = string(from: redSlaider)
        case 1:
            greenSlaider.value = text
            greenSliderLabel.text = string(from: greenSlaider)
        case 2:
            blueSlaider.value = text
            blueSliderLabel.text = string(from: blueSlaider)
        default:
            break
        }
        setColorForView()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        
        let newLength = text.count + string.count - range.length
        
        if newLength > 4 {
            let alert = UIAlertController(title: "Warning",
                                          message: "Invalid number of characters per line. Please enter no more than four characters.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true) { self.changeValue(for: self.redTextField, self.greenTextField, self.blueTextField) }
            return false
        }
        
        return newLength <= 4
    }
    
    private func createToolbar(_ textFields: UITextField...) {
     let toolbar = UIToolbar(frame:CGRect(x: 0,
                                          y: 0,
                                          width: UIScreen.main.bounds.width,
                                          height: 50))
     toolbar.barStyle = .default
     
     toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                            target: nil,
                            action: nil),
            UIBarButtonItem(barButtonSystemItem: .done,
                            target: self,
                            action: #selector(doneWithNumberPad))
     ]
        
     toolbar.sizeToFit()
     
     textFields.forEach { textField in
         textField.inputAccessoryView = toolbar
     }
     
    }
    
    @objc func doneWithNumberPad() {
        view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
