//
//  HandleConnection.swift
//  NewsApp
//
//  Created by Menna on 22/09/2022.
//

import Foundation
import Reachability
class HandelConnection{
    static let handelConnection = HandelConnection()
    var reachability: Reachability?
    func checkNetworkConnection(complition: @escaping (Bool)-> Void){
        reachability = try! Reachability()
        guard let reachability = reachability else {return}
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
                complition(true)
            } else {
                print("Reachable via Cellular")
                complition(true)
            }
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            complition(false)
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

}
extension UIViewController{
    func showAlertForInterNetConnection(){
        let alert = UIAlertController(title: "network is not connected", message: "please, check your internet connection", preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
    func alertWarning(indexPath:IndexPath,title:String,message:String){
        let alert = UIAlertController(title:title , message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive))
        self.present(alert, animated: true, completion: nil)
    }
}
