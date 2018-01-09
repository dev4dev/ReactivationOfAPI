//
//  Observable+Addition.swift
//  PromisesSandbox
//
//  Created by Alex Antonyuk on 1/9/18.
//  Copyright © 2018 Alex Antonyuk. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType where E == String {
    func mapToModel<Model: Mappable>() -> Observable<Model> {
        return map { json -> Model in
            return try Model(value: json)
        }.observeOn(MainScheduler.instance)
    }
}

