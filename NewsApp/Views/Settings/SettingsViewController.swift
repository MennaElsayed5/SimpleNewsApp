//
//  SettingsViewController.swift
//  NewsApp
//
//  Created by Menna on 23.9.22.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var segment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
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
