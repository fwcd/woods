//
//  SimpleUIViewControllerRepresentable.swift
//  Woods
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

protocol SimpleUIViewControllerRepresentable: UIViewControllerRepresentable {
    /// Creates a view controller from just the coordinator
    func makeUIViewController(coordinator: Coordinator) -> UIViewControllerType
}

extension SimpleUIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewControllerType {
        makeUIViewController(coordinator: context.coordinator)
    }
    
    /// Presents the view controller with UIKit on the root view controller.
    /// Note that this should only be used if you do not intend to transfer
    /// any data back from the view controller back to the app, since it
    /// does not mix very well with SwiftUI's data flow.
    ///
    /// Only use this e.g. for static notices, alerts, share sheets or similar.
    func presentIndependently() {
        let viewController = makeUIViewController(coordinator: makeCoordinator())
        UIApplication
            .shared
            .connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .first?
            .rootViewController?
            .present(viewController, animated: true, completion: nil)
    }
}
