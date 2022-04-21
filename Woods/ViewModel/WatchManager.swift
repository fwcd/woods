//
//  WatchManager.swift
//  Woods
//
//  Created by Fredrik on 21.04.22.
//

import Foundation
import WatchConnectivity

/// The manager that communicates with the watch on behalf of the host app.
class WatchManager: NSObject, ObservableObject, WCSessionDelegate {
    private var session: WCSession?
    
    override init() {
        super.init()
        
        if WCSession.isSupported() {
            session = WCSession.default
            session!.delegate = self
            session!.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // TODO
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        // TODO
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // TODO
    }
}
