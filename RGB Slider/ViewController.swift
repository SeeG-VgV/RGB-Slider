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
        
        createToolbar(for: redTextField)
        createToolbar(for: blueTextField)
        createToolbar(for: greenTextField)
        
        setColorForView()
        changeValuesTextFields()
        changeValueLabel()
    }
    
    @IBAction func valueChanget() {
        setColorForView()
        changeValuesTextFields()
        changeValueLabel()
    }
    
    private func setColorForView() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlaider.value),
                                            green: CGFloat(greenSlaider.value),
                                            blue: CGFloat(blueSlaider.value),
                                            alpha: 1)
    }
    
    private func changeValuesTextFields() {
        redSliderLabel.text = String(format: "%.2f", redSlaider.value)
        greenSliderLabel.text = String(format: "%.2f", greenSlaider.value)
        blueSliderLabel.text = String(format: "%.2f", blueSlaider.value)
    }
    
    private func changeValueLabel() {
        redTextField.text = String(format: "%.2f", redSlaider.value)
        greenTextField.text = String(format: "%.2f", greenSlaider.value)
        blueTextField.text = String(format: "%.2f", blueSlaider.value)
    }
    
    private func createToolbar(for textField: UITextField) {
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
        textField.inputAccessoryView = toolbar
       }
       
       @objc func doneWithNumberPad() {
           view.endEditing(true)
       }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = Float(textField.text!) else {
            
            changeValuesTextFields()
            
            return
        }
        
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
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                self?.changeValuesTextFields()
            }))
            present(alert, animated: true, completion: nil)
            return false
        }
        
        return newLength <= 4
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
