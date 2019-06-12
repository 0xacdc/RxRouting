//
//  Matcher.swift
//  RxRouting
//
//  Created by Bas van Kuijck on 05/06/2019.
//  Copyright © 2019 E-sites. All rights reserved.
//

import Foundation

class Matcher {
    let valueConverters: [RouteMatchResultValueType.Type] = [
        String.self,
        Bool.self,
        Float.self,
        Int.self,
        UUID.self,
        Date.self
    ]

    init() {

    }
    
    func match(url: URL, from candidate: String) -> RouteMatchResult? {
        let urlString = url.normalizedString
        if urlString.urlValue?.scheme != candidate.urlValue?.scheme {
            return nil
        }
        var result = _match(_stringPathComponents(from: urlString), with: candidate)
        result?.url = url
        return result
    }

    private func _match(_ pathComponents: [String], with candidate: String) -> RouteMatchResult? {
        let candidatePathComponents = _stringPathComponents(from: candidate).map(MatcherPathComponent.init)

        var urlValues: [String: Any] = [:]

        let pairCount = min(pathComponents.count, candidatePathComponents.count)
        for index in 0..<pairCount {
            let result = _matchStringPathComponent(at: index, from: pathComponents, with: candidatePathComponents)

            switch result {
            case let .matches(placeholderValue):
                if let (key, value) = placeholderValue {
                    urlValues[key] = value
                }

            case .notMatches:
                return nil
            }
        }

        return RouteMatchResult(pattern: candidate, values: urlValues)
    }

    private func _matchStringPathComponent(at index: Int,
                                          from stringPathComponents: [String],
                                          with candidatePathComponents: [MatcherPathComponent]) -> MatcherPathComponentResult {
        let stringPathComponent = stringPathComponents[index]

        switch candidatePathComponents[index] {
        case let .plain(value):
            guard stringPathComponent == value else {
                return .notMatches
            }
            return .matches(nil)

        case let .placeholder(type, key):
            guard let converter = valueConverters.first(where: { $0.typeName == type }) else {
                return .matches((key, stringPathComponent))
            }

            if let value = converter.from(pathComponents: stringPathComponents, index: index) {
                return .matches((key, value))
            } else {
                return .notMatches
            }
        }
    }

    private func _stringPathComponents(from urlString: String) -> [String] {
        return urlString.components(separatedBy: "/").lazy
            .filter { !$0.isEmpty }
            .filter { !$0.hasSuffix(":") }
    }
}
