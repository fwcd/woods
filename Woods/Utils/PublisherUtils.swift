//
//  PublisherUtils.swift
//  Woods
//
//  Created by Fredrik on 3/1/21.
//  Copyright © 2021 Fredrik.
//

import Combine

extension Publisher where Failure == Never {
    func weakenError<E>() -> Publishers.MapError<Self, E> {
        mapError { $0 }
    }
}
