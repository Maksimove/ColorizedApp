//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by fear on 11.05.2024.
//

import UIKit

protocol SettingVieControllerDelegate: AnyObject {
    func setBackgroundColor(_ color: UIColor)
}

final class MainViewController: UIViewController {
    
    private var backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingVC = segue.destination as? SettingsViewController else { return }
        settingVC.delegate = self
        settingVC.backgroundColor = backgroundColor
    }


}

extension MainViewController: SettingVieControllerDelegate {
    func setBackgroundColor(_ color: UIColor) {
        backgroundColor = color
        view.backgroundColor = backgroundColor
    }
    
    
}
