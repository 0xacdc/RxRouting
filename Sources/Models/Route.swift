//
//  Route.swift
//  RxRouting
//
//  Created by Bas van Kuijck on 05/06/2019.
//  Copyright © 2019 E-sites. All rights reserved.
//

import Foundation
import RxSwift

class Route: Equatable, CustomDebugStringConvertible {
    private let uuid = UUID().uuidString

    let url: String
    let observer: AnyObserver<RouteMatchResult>

    init(url: String, observer: AnyObserver<RouteMatchResult>) {
        self.url = url
        self.observer = observer
    }

    static func == (lhs: Route, rhs: Route) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    var debugDescription: String {
        return "<Route> [ uuid: \(uuid), url: \(url) ]"
    }
}
