//
//  ViewController.swift
//  RxRoutingExample
//
//  Created by Bas van Kuijck on 05/06/2019.
//  Copyright © 2019 E-sites. All rights reserved.
//

import UIKit
import RxRouting
import RxSwift

class ViewController: UIViewController {
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        RxRouting.instance
            .register("rxroutingexample://hello/users/%/%/%>", Int.self, String.self, Bool.self)
            .debug("//hello/ [1]")
            .subscribe(onNext: { [weak self] _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    self?.disposeBag = DisposeBag()
                }
            })
            .disposed(by: disposeBag)
    }
}

