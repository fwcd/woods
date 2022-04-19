//
//  BindingUtils.swift
//  Woods
//
//  Created by Fredrik on 19.04.22.
//

import SwiftUI

func unwrappingBinding<T>(for binding: Binding<T?>, defaultingTo defaultValue: T) -> Binding<T> where T: Equatable {
    Binding(
        get: { binding.wrappedValue ?? defaultValue },
        set: { binding.wrappedValue = $0 == defaultValue ? nil : $0 }
    )
}

func roundingIntBinding<F, I>(for binding: Binding<F>) -> Binding<I> where F: BinaryFloatingPoint, I: BinaryInteger {
    Binding(
        get: { I(binding.wrappedValue.rounded()) },
        set: { binding.wrappedValue = F($0) }
    )
}

func roundingFloatBinding<F, I>(for binding: Binding<I>) -> Binding<F> where F: BinaryFloatingPoint, I: BinaryInteger {
    Binding(
        get: { F(binding.wrappedValue) },
        set: { binding.wrappedValue = I($0.rounded()) }
    )
}

func stringBinding(for binding: Binding<Degrees>) -> Binding<String> {
    Binding(
        get: { String(binding.wrappedValue.totalDegrees) },
        set: {
            if let degrees = Double($0).map(Degrees.init(degrees:)) {
                binding.wrappedValue = degrees
            }
        }
    )
}
