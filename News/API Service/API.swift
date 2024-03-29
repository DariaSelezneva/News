//
//  API.swift
//  News
//
//  Created by dunice on 04.05.2022.
//

import Foundation

struct API {
    
    // MARK: - Strings
    
    static private let baseURL = "https://news-feed.dunice-testing.com/api/v1"
    
    static private let auth = "/auth"
    static private let login = "/login"
    static private let register = "/register"
    
    static private let file = "/file"
    static private let uploadFile = "/uploadFile"
    
    static private let news = "/news"
    static private let find = "/find"
    static private let user = "/user"
    
    static private let info = "/info"
    
    // MARK: - URLs
    
    static let loginURL = baseURL + auth + login
    static let registerURL = baseURL + auth + register
    
    static let uploadFileURL = baseURL + file + uploadFile
    
    static let newsURL = baseURL + news
    static let findNewsURL = baseURL + news + find
    
    static let userURL = baseURL + user
    static let getUserInfoURL = baseURL + user + info
}
