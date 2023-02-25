//
//  CompatibilityLayer.swift
//  Woods
//
//  Created by Fredrik on 14.04.22.
//

import SwiftUI

enum UserInterfaceIdiom: Hashable {
    case phone
    case pad
    case mac
    case tv
    case carPlay
    case unspecified
}

#if canImport(UIKit)

typealias UIOrNSViewRepresentable = UIViewRepresentable
typealias UIOrNSViewControllerRepresentable = UIViewControllerRepresentable
typealias UIOrNSColor = UIColor
typealias UIOrNSImage = UIImage

extension UserInterfaceIdiom {
    static var current: UserInterfaceIdiom { Self(fromUIKit: UIDevice.current.userInterfaceIdiom) }
    
    init(fromUIKit idiom: UIUserInterfaceIdiom) {
        switch idiom {
        case .phone: self = .phone
        case .pad: self = .pad
        case .tv: self = .tv
        case .carPlay: self = .carPlay
        case .mac: self = .mac
        case .unspecified: self = .unspecified
        @unknown default: self = .unspecified
        }
    }
}

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

extension UserInterfaceIdiom {
    static var current: UserInterfaceIdiom { .mac }
}

#else
#error("Unsupported platform!")
#endif
#endif
