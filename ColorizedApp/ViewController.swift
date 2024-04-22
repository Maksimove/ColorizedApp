import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet var valueOfRedSlider: UILabel!
    @IBOutlet var valueOfGreenSlider: UILabel!
    @IBOutlet var valueOfBlueSlider: UILabel!
    
    @IBOutlet var redComponent: UISlider!
    @IBOutlet var greenComponent: UISlider!
    @IBOutlet var blueComponent: UISlider!
    
    @IBOutlet var colorView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        valueOfRedSlider.text = "0.05"
        valueOfGreenSlider.text = "0.27"
        valueOfBlueSlider.text = "0.49"
        
        colorView.layer.cornerRadius = 15
        colorChange()
    }

    @IBAction func changeValueRedComponent() {
        valueOfRedSlider.text = String(format: "%.2f", redComponent.value)
        colorChange()
    }
    @IBAction func changeValueGreenComponent() {
        valueOfGreenSlider.text = String(format: "%.2f", greenComponent.value)
        colorChange()
    }
    @IBAction func changeValueBlueComponent() {
        valueOfBlueSlider.text = String(format: "%.2f", blueComponent.value)
        colorChange()
    }
    
    private func colorChange() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redComponent.value),
            green: CGFloat(greenComponent.value),
            blue: CGFloat(blueComponent.value),
            alpha: 1
        )
    }

}

