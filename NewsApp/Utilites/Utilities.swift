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
    func addUserCotgory(userCotgory: String){
        UserDefaults.standard.set(userCotgory, forKey: "catgory")
    }
    
    func getUserCotgory()-> String{
        return UserDefaults.standard.value(forKey: "catgory") as? String ?? ""
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
