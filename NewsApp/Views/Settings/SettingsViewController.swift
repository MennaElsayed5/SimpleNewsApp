//
//  SettingsViewController.swift
//  NewsApp
//
//  Created by Menna on 23.9.22.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func segment(_ sender: Any) {
    }
    @IBAction func darkMoodSwitch(_ sender: UISwitch) {
//        if #available(iOS 13.0, *){
//            let appDelegaget = UIApplication.shared.windows.first
//            if sender.isOn {
//            appDelegaget?.overrideUserInterfaceStyle = .dark
//            return
//        }
//        appDelegaget?.overrideUserInterfaceStyle = .light
//        }

    }
    
    @IBAction func selectTheme(_ sender: UISegmentedControl) {
        Utilities.utilities.theme = Theme(rawValue: sender.selectedSegmentIndex) ?? .light
        self.view.window?.overrideUserInterfaceStyle = Utilities.utilities.theme.getUserInterfaceStyle()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
