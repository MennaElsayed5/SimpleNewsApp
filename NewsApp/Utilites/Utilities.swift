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
