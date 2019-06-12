//
//  MatcherPathComponentResult.swift
//  RxRouting
//
//  Created by Bas van Kuijck on 05/06/2019.
//

import Foundation

enum MatcherPathComponentResult {
    case matches((key: String, value: RouteMatchResultValueType)?)
    case notMatches
}
