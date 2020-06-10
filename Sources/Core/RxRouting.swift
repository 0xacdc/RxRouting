//
//  RxRouting.swift
//  RxRouting
//
//  Created by Bas van Kuijck on 05/06/2019.
//  Copyright © 2019 E-sites. All rights reserved.
//

import Foundation
import RxSwift

/// RxRouting provides a reactive way of listening for deeplinks
public class RxRouting {
    
    /// Get a singleton instance.
    public static let instance = RxRouting()

    fileprivate let _matcher = Matcher()
    fileprivate var _routes: [Route] = []

    private init() {
    }
}

// MARK: - Registering
// --------------------------------------------------------

extension RxRouting {

    /// Registers a url pattern
    ///
    /// **Example:**
    ///
    /// ```
    /// RxRouting.instance
    ///     .register("rxroutingexample://user/<userid:int>"
    ///     .subscribe(onNext: { result in
    ///         // result is a RouteMatchResult
    ///     }.disposed(by: disposeBag)
    /// ```
    ///
    /// - Parameters:
    ///   - url: `String`
    ///
    /// - Returns: `Observable<RouteMatchResult>`
    public func register(_ url: String) -> Observable<RouteMatchResult> {
        return Observable<RouteMatchResult>.create { [unowned self] observer in
            let route = Route(url: url, observer: observer)
            self._routes.append(route)

            return Disposables.create {
                self._routes.removeAll { $0 == route }
            }
        }
    }
}

// MARK: - Handling
// --------------------------------------------------------

extension RxRouting {
    /// Handles an URL that is openened from an external application (e.g. Safari).
    ///
    /// **Example:**
    /// ```
    /// func application(_ app: UIApplication,
    ///                  open url: URL,
    ///                  options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    ///     if RxRouting.instance.handle(url: url) {
    ///         return true
    ///     }
    ///     return false
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - url: `URL`
    ///
    /// - Returns: `Bool`. Was the URL handled / catched?
    public func handle(url: URL) -> Bool {
        return !_routes.filter { route in
            guard let result = _matcher.match(url: url, from: route.url) else {
                return false
            }
            route.observer.onNext(result)
            return true
        }.isEmpty
    }

    public func canHandle(url: URL) -> Bool {
        return !_routes.filter { _matcher.match(url: url, from: $0.url) != nil }.isEmpty
    }
}
