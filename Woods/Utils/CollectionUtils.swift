//
//  CollectionUtils.swift
//  Woods
//
//  Created by Fredrik on 21.11.21.
//  Copyright © 2021 Fredrik.
//

extension Collection {
    var nilIfEmpty: Self? {
        isEmpty ? nil : self
    }
}
