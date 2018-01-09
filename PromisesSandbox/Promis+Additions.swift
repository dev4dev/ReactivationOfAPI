//
//  Promis+Additions.swift
//  PromisesSandbox
//
//  Created by Alex Antonyuk on 1/9/18.
//  Copyright © 2018 Alex Antonyuk. All rights reserved.
//

import Foundation
import Hydra

extension Promise where Value == String {
    func mapToModel<Model: Mappable>() -> Promise<Model> {
        return then(in: .background, { json in
            return try Model(value: json)
        })
    }
}
