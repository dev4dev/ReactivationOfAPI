//
//  Promis+Additions.swift
//  PromisesSandbox
//
//  Created by Alex Antonyuk on 1/9/18.
//  Copyright © 2018 Alex Antonyuk. All rights reserved.
//

import Foundation
import Hydra

extension Promise where Value == Data {
    func mapToModel<Model: Mappable>() -> Promise<Model> {
        return then(in: .background, { jsonData in
            guard let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else { throw MappingError.failed }

            do {
                let model = try Model(json: json)
                return Promise<Model>(resolved: model)
            }
        })
    }

    func mapToModels<Model: Mappable>(key: String) -> Promise<[Model]> {
        return then(in: .background, { jsonData in
            guard let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else { throw MappingError.failed }
            guard let items = json[key] as? [JSON] else { throw MappingError.failed }

            do {
                let models = try items.flatMap({ json in
                    try Model(json: json)
                })
                return Promise<[Model]>(resolved: models)
            }
        })
    }
}
