//
//  Model.swift
//  PromisesSandbox
//
//  Created by Alex Antonyuk on 1/9/18.
//  Copyright © 2018 Alex Antonyuk. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

protocol Mappable {
    init(json: JSON) throws
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
    required init(json: JSON) throws {
        print("mapping \(Thread.isMainThread)")
        self.value = json["value"] as! String
    }
}

// --
final class Artist: Mappable {
    let id: Int
    let name: String
    let link: URL

    init(json: JSON) throws {


        id = json["id"] as! Int
        name = json["name"] as! String
        link = URL(string: json["link"] as! String)!
    }
}

final class Album: Mappable {
    let id: Int
    let title: String

    init(json: JSON) throws {

        id = json["id"] as! Int
        title = json["title"] as! String
    }
}
