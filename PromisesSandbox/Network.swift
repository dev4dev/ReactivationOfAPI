//
//  API.swift
//  PromisesSandbox
//
//  Created by Alex Antonyuk on 1/8/18.
//  Copyright © 2018 Alex Antonyuk. All rights reserved.
//

import Foundation
import Hydra
import RxSwift

enum NetworkErrors: Error, AlertRepresentable {
    case noGood

    var message: String {
        return "HTTP Error"
    }
}

final class Network {

    func request() -> Promise<String> {
        return Promise(in: .background, { resolve, reject, _ in
            if arc4random_uniform(10) > 2 {
                resolve("OK")
            } else {
                throw NetworkErrors.noGood
            }
        })
    }

    func rxRequest() -> Observable<String> {
        return Observable.create { obs in
            print("Observe \(Thread.isMainThread)")
            obs.onNext("RxSwift")
            obs.onCompleted()

            return Disposables.create()
        }.subscribeOn(SerialDispatchQueueScheduler(qos: .background))
    }

}
