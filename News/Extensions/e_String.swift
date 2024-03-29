//
//  e_String.swift
//  News
//
//  Created by dunice on 11.05.2022.
//

import Foundation

extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}

extension String {
    
    subscript(range: Range<Int>) -> SubSequence {
            let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
            return self[startIndex..<index(startIndex, offsetBy: range.count)]
        }
    
    func tags() -> [String] {
        let range = NSRange(location: 0, length: self.utf16.count)
        let regex = try! NSRegularExpression(pattern: "#[A-Za-z0-9]+")
        let matches = regex.matches(in: self, options: [], range: range)
        let ranges = matches.compactMap({ Range($0.range) })
        let strings = ranges.map({ String(self[$0].dropFirst()) })
        return strings
    }
}

extension String {
    
    func withoutExtraSpaces() -> String {
        var string = self
        while string.contains("  ") {
            string = string.replacingOccurrences(of: "  ", with: " ")
        }
        while string.last == " " {
            string.removeLast()
        }
        return string
    }
    
    var isValidEmail: Bool {
        let pattern = "^([A-Za-z0-9]+)([@]{1})([a-z]+)([.]{1})([a-z]+)$"
        return self.range(of: pattern, options: .regularExpression) != nil
    }
    
    var isValidPassword: Bool {
        let pattern = "^([A-Za-z0-9]+)$"
        let matchesRegex = self.range(of: pattern, options: .regularExpression) != nil
        let matchesCount = self.count >= 6 && self.count <= 60
        return matchesRegex && matchesCount
    }
}
