//
//  MatcherPathComponent.swift
//  RxRouting
//
//  Created by Bas van Kuijck on 05/06/2019.
//  Copyright © 2019 E-sites. All rights reserved.
//

import Foundation

enum MatcherPathComponent {
    case plain(String)
    case placeholder(type: String, key: String)
}

extension MatcherPathComponent {
    init(_ value: String) {
        if value.hasPrefix("<") && value.hasSuffix(">") {
            let start = value.index(after: value.startIndex)
            let end = value.index(before: value.endIndex)
            let placeholder = value[start..<end] // e.g. "<id:int>" -> "id:int"
            let typeAndKey = placeholder.components(separatedBy: ":")
            if typeAndKey.count == 1 { // no type, default = string
                self = .placeholder(type: String.typeName, key: typeAndKey[0])
                return

            } else if typeAndKey.count == 2 {
                self = .placeholder(type: typeAndKey[1], key: typeAndKey[0])
                return
            }
        }
        
        self = .plain(value)
    }
}

extension MatcherPathComponent: Equatable {
    static func == (lhs: MatcherPathComponent, rhs: MatcherPathComponent) -> Bool {
        switch (lhs, rhs) {
        case let (.plain(leftValue), .plain(rightValue)):
            return leftValue == rightValue

        case let (.placeholder(leftType, leftKey), .placeholder(rightType, key: rightKey)):
            return (leftType == rightType) && (leftKey == rightKey)

        default:
            return false
        }
    }
}
