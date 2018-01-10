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

enum APIErrors: Error, AlertRepresentable {
    case mappingError
    case generic(String)

    var message: String {
        switch self {
        case .mappingError:
            return "Mapping error"
        case .generic(let message):
            return message
        }
    }
}

final class API {
    private let network: Network
    init(network: Network) {
        self.network = network
    }

    func object() -> Promise<Model> {
        return network.request().mapToModel()
    }

    func object() -> Observable<Model> {
        return network.request().mapToModel()
    }

    // --
    func getArtist() -> Promise<Artist> {
        return network.get(url: URL(string: "https://api.deezer.com/artist/1")!).mapToModel()
    }

    func getArtist() -> Observable<Artist> {
        return network.get(url: URL(string: "https://api.deezer.com/artist/1")!).mapToModel()
    }

    func getAlbums(for artist: Artist) -> Promise<[Album]> {
        return network.get(url: URL(string: "https://api.deezer.com/artist/\(artist.id)/albums")!).mapToModels(key: "data")
    }

    func getAlbums(for artist: Artist) -> Observable<[Album]> {
        return network.get(url: URL(string: "https://api.deezer.com/artist/\(artist.id)/albums")!).mapToModels(key: "data")
    }
}
