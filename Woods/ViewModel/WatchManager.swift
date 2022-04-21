//
//  WatchManager.swift
//  Woods
//
//  Created by Fredrik on 21.04.22.
//

import Foundation
import WatchConnectivity
import OSLog

private let log = Logger(subsystem: "Woods", category: "WatchManager")

/// The manager that communicates with the watch on behalf of the host app.
class WatchManager: NSObject, ObservableObject, WCSessionDelegate {
    private var session: WCSession?
    
    /// The target that the user currently navigates to.
    var navigationTarget: Coordinates? {
        didSet {
            send(WatchProtocolKey.navigationTarget, navigationTarget)
        }
    }
    
    override init() {
        super.init()
        
        if WCSession.isSupported() {
            session = WCSession.default
            session!.delegate = self
            session!.activate()
            log.info("Activated watch connectivity session")
        }
    }
    
    private func send<Value>(_ key: WatchMessageKey<Value>, _ value: Value) {
        guard let session = session, session.isPaired && session.isWatchAppInstalled else { return }
        log.info("Sending \(key.rawValue)...")
        session.sendMessage([key.rawValue: value], replyHandler: nil)
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
