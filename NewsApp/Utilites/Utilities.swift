//
//  Utilities.swift
//  NewsApp
//
//  Created by Menna on 21/09/2022.
//

import Foundation
class Utilities{
    static let utilities = Utilities()
    func setIsFirstTimeInApp(){
        UserDefaults.standard.set(true, forKey: "isFirst")
    }
    func isFirstTimeInApp() ->Bool {
        return UserDefaults.standard.bool(forKey: "isFirst")
    }
    
}
