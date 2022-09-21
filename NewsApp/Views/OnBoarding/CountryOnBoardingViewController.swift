//
//  CountryOnBoardingViewController.swift
//  NewsApp
//
//  Created by Menna on 21/09/2022.
//

import UIKit
import DropDown
class CountryOnBoardingViewController: UIViewController {

    @IBOutlet weak var lableCountry: UILabel!
    @IBOutlet var onboardingView: UIView!
    let dropDown = DropDown()
    let  countryArray = ["ae", "ar", "at","au","be","bg","br","ca","ch","cn","co","cu","cz","de","eg","fr","gb","gr","hk","hu","id","ie","il","in","it","jp","kr","lt","lv","ma","mx","my","ng","nl","no","nz","ph","pl","pt","ro","rs","ru","sa","se","sg","si","sk","th","tr","tw","ua","us","ve","za"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDown.anchorView = onboardingView // UIView or UIBarButtonItem
        dropDown.dataSource = countryArray
      
        dropDown.selectionAction = {
            [unowned self] (index: Int, item: String) in
              print("Selected item: \(item) at index: \(index)")
            self.lableCountry.text = countryArray[index]
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dropBtn(_ sender: Any) {
        dropDown.show()

    }
    
    @IBAction func nextBtn(_ sender: Any) {
        let catgory = self.storyboard?.instantiateViewController(identifier: "CatgoryOnboardingViewController") as! CatgoryOnboardingViewController
        catgory.countaryName = lableCountry.text
         self.navigationController?.pushViewController(catgory, animated: true)
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
