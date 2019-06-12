//
//  RouteMatchResult.swift
//  RxRouting
//
//  Created by Bas van Kuijck on 05/06/2019.
//  Copyright © 2019 E-sites. All rights reserved.
//

import Foundation

public protocol ValueType {

}

extension String: ValueType { }
extension Int: ValueType { }
extension Float: ValueType { }
extension Bool: ValueType { }
extension UUID: ValueType { }
extension Date: ValueType { }

protocol RouteMatchResultValueType {
    static var typeName: String { get }
    static func from(pathComponents: [String], index: Int) -> Self?
}

extension RouteMatchResultValueType {
    static var typeName: String {
        return "\(self)".lowercased()
    }
}

extension String: RouteMatchResultValueType {
    static func from(pathComponents: [String], index: Int) -> String? {
        return pathComponents[index]
    }
}

extension Int: RouteMatchResultValueType {
    static func from(pathComponents: [String], index: Int) -> Int? {
        return Int(pathComponents[index])
    }
}

extension Date: RouteMatchResultValueType {
    static func from(pathComponents: [String], index: Int) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.date(from: pathComponents[index])
    }
}

extension Bool: RouteMatchResultValueType {
    static func from(pathComponents: [String], index: Int) -> Bool? {
        return pathComponents[index] == "true" || pathComponents[index] == "1"
    }
}

extension UUID: RouteMatchResultValueType {
    static func from(pathComponents: [String], index: Int) -> UUID? {
        return UUID(uuidString: pathComponents[index])
    }
}

extension Float: RouteMatchResultValueType {
    static func from(pathComponents: [String], index: Int) -> Float? {
        return Float(pathComponents[index])
    }
}

public struct RouteMatchResult {
    public let pattern: String
    public let values: [String: Any]
    internal(set) public var url: URL!

    init(pattern: String, values: [String: Any]) {
        self.pattern = pattern
        self.values = values
    }
}
