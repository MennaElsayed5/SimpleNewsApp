//
//  Utilities.swift
//  NewsApp
//
//  Created by Menna on 21/09/2022.
//

import Foundation
import SwiftMessages
class Utilities{
    static let utilities = Utilities()
    func setIsFirstTimeInApp(){
        UserDefaults.standard.set(true, forKey: "isFirst")
    }
    func isFirstTimeInApp() ->Bool {
        return UserDefaults.standard.bool(forKey: "isFirst")
    }
    func addUserCountry(userCountry: String){
        UserDefaults.standard.set(userCountry, forKey: "country")
    }
    
    func getUserCountry()-> String{
        return UserDefaults.standard.value(forKey: "country") as? String ?? ""
    }
    func addArrCotgory(userCotgory: Array<Any>){
        UserDefaults.standard.set(userCotgory, forKey: "catgory")
    }
    
    func getArrCotgory()-> Array<Any>{
        return UserDefaults.standard.value(forKey: "catgory") as? Array<Any> ?? []
    }
    func showMessage(message:String, error:Bool){
        let view = MessageView.viewFromNib(layout: .messageView)
        if error == true {
            view.configureTheme(.error)
        }else{
            view.configureTheme(.success)
        }
        view.button?.isHidden = true
        view.titleLabel?.isHidden = true
        view.bodyLabel?.text = message
        var config = SwiftMessages.Config()
        config.presentationStyle = .top
        SwiftMessages.show(config: config, view: view)
    }
}
extension UIViewController{
    func alertWarning(indexPath:IndexPath,title:String,message:String){
        let alert = UIAlertController(title:title , message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive))
        self.present(alert, animated: true, completion: nil)
    }
    
}
