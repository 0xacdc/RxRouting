//
//  URL+extensions.swift
//  RxRouting
//
//  Created by Bas van Kuijck on 05/06/2019.
//  Copyright © 2019 E-sites. All rights reserved.
//

import Foundation

extension URL {
    var normalizedString: String {
        var urlString = absoluteString
        urlString = urlString.components(separatedBy: "?")[0].components(separatedBy: "#")[0]
        urlString = _replaceRegex(":/{3,}", "://", urlString)
        urlString = _replaceRegex("(?<!:)/{2,}", "/", urlString)
        urlString = _replaceRegex("(?<!:|:/)/+$", "", urlString)
        return urlString
    }

    private func _replaceRegex(_ pattern: String, _ repl: String, _ string: String) -> String {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return string
        }
        let range = NSRange(location: 0, length: string.count)
        return regex.stringByReplacingMatches(in: string, options: [], range: range, withTemplate: repl)
    }
}
