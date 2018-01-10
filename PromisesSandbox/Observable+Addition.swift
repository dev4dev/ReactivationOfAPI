//
//  Observable+Addition.swift
//  PromisesSandbox
//
//  Created by Alex Antonyuk on 1/9/18.
//  Copyright © 2018 Alex Antonyuk. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType where E == Data {
    func mapToModel<Model: Mappable>() -> Observable<Model> {
        return map { jsonData in
            guard let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else { throw MappingError.failed }

            return try Model(json: json)
        }.observeOn(MainScheduler.instance)
    }

    func mapToModels<Model: Mappable>(key: String) -> Observable<[Model]> {
        return map { jsonData in
            guard let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else { throw MappingError.failed }
            guard let items = json[key] as? [JSON] else { throw MappingError.failed }

            let models = try items.flatMap { json in
                try Model(json: json)
            }
            return models
        }.observeOn(MainScheduler.instance)
    }
}

