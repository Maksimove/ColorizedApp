import UIKit

final class SettingsViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var valueOfRedSlider: UILabel!
    @IBOutlet var valueOfGreenSlider: UILabel!
    @IBOutlet var valueOfBlueSlider: UILabel!
    
    @IBOutlet var redComponent: UISlider!
    @IBOutlet var greenComponent: UISlider!
    @IBOutlet var blueComponent: UISlider!
    
    @IBOutlet var redColorTF: UITextField!
    @IBOutlet var greenColorTF: UITextField!
    @IBOutlet var blueColorTF: UITextField!
    
    @IBOutlet var colorView: UIView!
    // MARK: - Custom Properties
    weak var delegate: SettingVieControllerDelegate?
    
    var backgroundColor: UIColor!
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getColorsForSliders()
        
        redColorTF.delegate = self
        greenColorTF.delegate = self
        blueColorTF.delegate = self

        valueOfRedSlider.text = string(from: redComponent)
        valueOfGreenSlider.text = string(from: greenComponent)
        valueOfBlueSlider.text = string(from: blueComponent)
        
        redColorTF.text = string(from: redComponent)
        greenColorTF.text = string(from: greenComponent)
        blueColorTF.text = string(from: blueComponent)
        
        colorView.layer.cornerRadius = 15
        
        colorChangeFromSlider()
        createToolBarForTextField()
    }
    // MARK: - Hiding the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    // MARK: - IBActions
    @IBAction func changeValueComponent(_ sender: UISlider) {
        colorChangeFromSlider()
        
        switch sender {
        case redComponent:
            valueOfRedSlider.text = string(from: redComponent)
            redColorTF.text = string(from: redComponent)
        case greenComponent:
            valueOfGreenSlider.text = string(from: greenComponent)
            greenColorTF.text = string(from: greenComponent)
        default:
            valueOfBlueSlider.text = string(from: blueComponent)
            blueColorTF.text = string(from: blueComponent)
        }
    }
    @IBAction func changeColorForMain() {
        delegate?.setBackgroundColor(changeBackGroundColor())
        view.endEditing(true)
        dismiss(animated: true)
    }
}
    // MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard validDataCheck(textField) else {
            showAlert(textField)
            return
        }
        
        if textField == redColorTF {
            redComponent.setValue(
                Float(textField.text ?? "") ?? 0,
                animated: true
            )
            colorChangeFromTF()
            valueOfRedSlider.text = textField.text
        } else if textField == greenColorTF {
            colorChangeFromTF()
            valueOfGreenSlider.text = textField.text
            greenComponent.setValue(
                Float(textField.text ?? "") ?? 0,
                animated: true
            )
        } else {
            colorChangeFromTF()
            valueOfBlueSlider.text = textField.text
            blueComponent.setValue(
                Float(textField.text ?? "") ?? 0,
                animated: true
            )
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
    // MARK: - Private Methods
private extension SettingsViewController {
    func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    func getColorsForSliders() {
        if let components = backgroundColor.cgColor.components {
            redComponent.setValue(Float(components[0]), animated: false)
            greenComponent.setValue(Float(components[1]), animated: false)
            blueComponent.setValue(Float(components[2]), animated: false)
        }
    }
    
    func createToolBarForTextField() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonPressed)
        )
        toolBar.items = [doneButton]
        redColorTF.inputAccessoryView = toolBar
        greenColorTF.inputAccessoryView = toolBar
        blueColorTF.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonPressed() {
        view.endEditing(true)
    }
    
    func colorChangeFromSlider() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redComponent.value),
            green: CGFloat(greenComponent.value),
            blue: CGFloat(blueComponent.value),
            alpha: 1
        )
    }
    
    func colorChangeFromTF() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(Float(redColorTF.text ?? "") ?? 1),
            green: CGFloat(Float(greenColorTF.text ?? "") ?? 1),
            blue: CGFloat(Float(blueColorTF.text ?? "") ?? 1),
            alpha: 1
        )
    }
    
    func changeBackGroundColor() -> UIColor {
        backgroundColor = colorView.backgroundColor
        return backgroundColor
    }
    
    func showAlert(_ textfield: UITextField) {
       let alert = UIAlertController(
            title: "Ошибка",
            message: "Некорректные данные",
            preferredStyle: .alert
        )
        let alertButton = UIAlertAction(title: "Ok", style: .default) { _ in
            textfield.text?.removeLast()
        }

        alert.addAction(alertButton)
        present(alert, animated: true)
    }
    
    func validDataCheck(_ textField: UITextField) -> Bool {
        let regex = "^0(?:\\.\\d{1,2})?$|^1(?:\\.0{1,2})?$"
        let validation = NSPredicate(
            format: "SELF MATCHES %@", regex).evaluate(with: textField.text
            )
        return validation
    }
}
