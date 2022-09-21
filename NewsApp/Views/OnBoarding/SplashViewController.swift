//
//  SplashViewController.swift
//  NewsApp
//
//  Created by Menna on 20/09/2022.
//

import UIKit
import Lottie
class SplashViewController: UIViewController {

    @IBOutlet weak var animationView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        let animationView = AnimationView()
        animationView.animation = Animation.named("splash")
        animationView.contentMode = .scaleAspectFit
        animationView.frame = view.bounds
        animationView.loopMode = .loop
        animationView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        animationView.center = view.center
        animationView.play()
        view.addSubview(animationView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else {return}
            let tabBar = self.storyboard?.instantiateViewController(identifier: "TabBarViewController") as! TabBarViewController
            let onboarding = self.storyboard?.instantiateViewController(identifier: "CountryOnBoardingViewController") as! CountryOnBoardingViewController
            if Utilities.utilities.isFirstTimeInApp(){
                self.navigationController?.pushViewController(tabBar, animated: true)

            }else{
                Utilities.utilities.setIsFirstTimeInApp()
                self.navigationController?.pushViewController(onboarding, animated: true)
                //self.navigationController?.pushViewController(a, animated: true)
//                let detailsVc = self.storyboard?.instantiateViewController(identifier: "LeaguesDetailsViewController") as! LeaguesDetailsViewController
//
//                detailsVc.countries = country[indexPath.row]
//                self.navigationController?.pushViewController(detailsVc, animated: true)
            }
            
        }
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
