//
//  ViewController.swift
//  PromisesSandbox
//
//  Created by Alex Antonyuk on 1/8/18.
//  Copyright © 2018 Alex Antonyuk. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    let network = Network()
    lazy var  api = API(network: network)
    private let trash = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func onRequest(_ sender: UIButton) {
        print("show HUD")
//        api.object().then(in: .main) { model in
//            print("Model \(model.value) - \(Thread.isMainThread)")
//        }.catch { (error) in
//            guard let error = error as? AlertRepresentable else { return }
//            print("Error \(error.message) - \(Thread.isMainThread)")
//        }.always {
//            print("hide HUD")
//        }

        api.rxObject().do(onDispose: {
            print("hide HUD")
        }).subscribe { event in
            print("sub \(Thread.isMainThread)")
            switch event {
            case .next(let model):
                print("Model \(model.value) - \(Thread.isMainThread)")
            case .error(let error):
                guard let error = error as? AlertRepresentable else { return }
                print("Error \(error.message) - \(Thread.isMainThread)")
            default:
                break
            }
        }.disposed(by: trash)
    }
}

