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
    
    @IBOutlet var labelRedForSlider: UILabel!
    @IBOutlet var labelGreenForSlider: UILabel!
    @IBOutlet var labelBlueForSlider: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 10
        
        createToolbar(for: redTextField)
        createToolbar(for: blueTextField)
        createToolbar(for: greenTextField)
        
        setColorForView()
        changeValuesLabelAndTextFields()
    }
    
    @IBAction func valueChanget() {
        changeValuesLabelAndTextFields()
        setColorForView()
    }
    
    private func setColorForView() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlaider.value), green: CGFloat(greenSlaider.value), blue: CGFloat(blueSlaider.value), alpha: 1)
    }
    
    private func changeValuesLabelAndTextFields() {
        labelRedForSlider.text = String(format: "%.2f", redSlaider.value)
        labelGreenForSlider.text = String(format: "%.2f", greenSlaider.value)
        labelBlueForSlider.text = String(format: "%.2f", blueSlaider.value)
        
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
            
            self.redTextField.text = String(format: "%.2f", self.redSlaider.value)
            self.greenTextField.text = String(format: "%.2f", self.greenSlaider.value)
            self.blueTextField.text = String(format: "%.2f", self.blueSlaider.value)
            
            return
        }
        
        switch textField.tag {
        case 0:
            redSlaider.value = text
            labelRedForSlider.text = String(format: "%.2f", redSlaider.value)
        case 1:
            greenSlaider.value = text
            labelGreenForSlider.text = String(format: "%.2f", greenSlaider.value)
        case 2:
            blueSlaider.value = text
            labelBlueForSlider.text = String(format: "%.2f", blueSlaider.value)
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
                self.redTextField.text = String(format: "%.2f", self.redSlaider.value)
                self.greenTextField.text = String(format: "%.2f", self.greenSlaider.value)
                self.blueTextField.text = String(format: "%.2f", self.blueSlaider.value)
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
