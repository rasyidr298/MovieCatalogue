//
//  Connectivity.swift
//  Movie
//
//  Created by Rasyid Ridla on 27/9/21.
//

import Foundation
import SystemConfiguration

// MARK: Reachability
class Reachability {
    public static let shared = Reachability()
    
    private init() { }
    
    func isNetworkAvailable() -> Bool {
        let reachability = SCNetworkReachabilityCreateWithName(nil, "www.google.com")
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)
        
        return isNetworkReachable(with: flags)
    }
    
    private func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        
        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
    }
}
