//
//  Model.swift
//  PromisesSandbox
//
//  Created by Alex Antonyuk on 1/9/18.
//  Copyright © 2018 Alex Antonyuk. All rights reserved.
//

import Foundation

protocol Mappable {
    init(value: String) throws
}

enum MappingError: Error, AlertRepresentable {
    case failed

    var message: String {
        switch self {
        case .failed:
            return "Failed to map"
        }
    }
}

class Model: Mappable {
    let value: String
    required init(value: String) throws {
        print("mapping \(Thread.isMainThread)")
        self.value = value
    }
}

