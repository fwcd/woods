//
//  CompatibilityLayer.swift
//  Woods
//
//  Created by Fredrik on 14.04.22.
//

import SwiftUI

#if canImport(UIKit)

typealias UIOrNSViewRepresentable = UIViewRepresentable
typealias UIOrNSViewControllerRepresentable = UIViewControllerRepresentable
typealias UIOrNSColor = UIColor
typealias UIOrNSImage = UIImage

#else
#if canImport(AppKit)

typealias UIOrNSViewRepresentable = NSViewRepresentable
typealias UIOrNSViewControllerRepresentable = NSViewControllerRepresentable
typealias UIOrNSColor = NSColor
typealias UIOrNSImage = NSImage

extension NSImage {
    convenience init(systemName: String) {
        self.init(systemSymbolName: systemName, accessibilityDescription: nil)!
    }
}

#else
#error("Unsupported platform!")
#endif
#endif
