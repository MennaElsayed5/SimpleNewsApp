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
