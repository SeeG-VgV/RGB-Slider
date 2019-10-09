//
//  ViewController.swift
//  RGB Slider
//
//  Created by Денис Иванов on 22.09.2019.
//  Copyright © 2019 Ivanov Denis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 10
        
        createToolbar(redTextField, greenTextField, blueTextField)
        
        setColorForView()
        changeValue(for: redTextField, greenTextField, blueTextField)
        changeValues(for: redSliderLabel, greenSliderLabel, blueSliderLabel)
    }
    
    @IBAction func valueChanget(_ sender: UISlider) {
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
    
    private func string(from slider: UISlider) -> String {
        return String(format: "%.2f", slider.value)
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        changeValues(for: redSliderLabel, greenSliderLabel, blueSliderLabel)
        
        guard let text = Float(textField.text!) else {
            changeValue(for: redTextField, greenTextField, blueTextField)
            return }
        
        switch textField.tag {
        case 0:
            redSlaider.value = text
            redSliderLabel.text = String(format: "%.2f", redSlaider.value)
        case 1:
            greenSlaider.value = text
            greenSliderLabel.text = String(format: "%.2f", greenSlaider.value)
        case 2:
            blueSlaider.value = text
            blueSliderLabel.text = String(format: "%.2f", blueSlaider.value)
        default:
            break
        }
        setColorForView()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        
        let newLength = text.count + string.count - range.length
        
        if newLength > 4 {
            let alert = UIAlertController(title: "Warning", message: "Invalid number of characters per line. Please enter no more than four characters.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.changeValue(for: self.redTextField, self.greenTextField, self.blueTextField)
            }))
            present(alert, animated: true, completion: nil)
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
     
     for textField in textFields {
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
