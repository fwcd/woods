//
//  ShareSheet.swift
//  Woods
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI
import OSLog

private let log = Logger(subsystem: "Woods", category: "ShareSheet")

struct ShareSheet: SimpleUIViewControllerRepresentable {
    let items: [Any]
    var onDismiss: (() -> Void)? = nil
    
    func makeUIViewController(coordinator: ()) -> UIActivityViewController {
        let vc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        vc.completionWithItemsHandler = { _, _, _, error in
            if let error = error {
                log.error("Error after completing share sheet: \(String(describing: error))")
                return
            }
            onDismiss?()
        }
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // Do nothing
    }
}
