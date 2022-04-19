//
//  SignedCardinal.swift
//  Woods
//
//  Created by Fredrik on 20.04.22.
//

import Foundation

protocol SignedCardinal {
    var sign: FloatingPointSign { get }
    
    init(sign: FloatingPointSign)
}
