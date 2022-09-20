//
//  RemoteHostManager.swift
//  Woods (WatchKit Extension)
//
//  Created by Fredrik on 21.04.22.
//

import WatchConnectivity

/// The manager that communicates with the host app on behalf of the watch.
class RemoteHostManager: NSObject, ObservableObject, WCSessionDelegate {
    private var session: WCSession?
    
    /// The target that the user currently navigates to.
    @MainActor @Published var navigationTarget: Coordinates?
    
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
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        if let update = message[WatchProtocol.NavigationTargetUpdate.key] {
            Task.detached { @MainActor in
                self.navigationTarget = update.navigationTarget
            }
        }
    }
}
