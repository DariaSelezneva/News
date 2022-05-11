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
