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

    func request() -> Promise<Data> {
        return Promise(in: .background, { resolve, reject, _ in
            if arc4random_uniform(10) > 2 {
                resolve("OK".data(using: .utf8)!)
            } else {
                throw NetworkErrors.noGood
            }
        })
    }

    func get(url: URL) -> Promise<Data> {
        return Promise(in: .background, { resolve, reject, _ in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    resolve(data)
                } else if let error = error {
                    reject(error)
                }
            }.resume()
        })

    }

    func get(url: URL) -> Observable<Data> {
        return Observable.create { obs in
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    obs.onNext(data)
                    obs.onCompleted()
                } else if let error = error {
                    obs.onError(error)
                }
            }

            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }

    }

    func request() -> Observable<Data> {
        return Observable.create { obs in
            print("Observe \(Thread.isMainThread)")
            obs.onNext("RxSwift".data(using: .utf8)!)
            obs.onCompleted()

            return Disposables.create()
        }.subscribeOn(SerialDispatchQueueScheduler(qos: .background))
    }

}
