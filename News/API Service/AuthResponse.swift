//
//  AuthResponse.swift
//  News
//
//  Created by Дарья Селезнёва on 10.05.2022.
//

import Foundation

struct AuthResponse {
    
    var id: String
    var avatar: String
    var email: String
    var name: String
    var role: String
    var token: String
    
    #if DEBUG
    static func mock(avatar: String? = nil, email: String, name: String? = nil) -> AuthResponse {
        AuthResponse(
            id: "23817669-18cc-4402-9707-7a49f93cbe25",
            avatar: avatar ?? "https://news-feed.dunice-testing.com/api/v1/file/693d86bf-fedd-47e8-8f00-332780ab46b8.",
            email: email,
            name: name ?? "Blabla",
            role: "user",
            token: "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyMzgxNzY2OS0xOGNjLTQ0MDItOTcwNy03YTQ5ZjkzY2JlMjUiLCJleHAiOjE2NTQ2NDY0MDB9.KhYE75Zsq4Xj6kdFHewJ1NABIdkdDFX5z6MeppB05rkmaayB9Jl9AfZN3TKOo_giBMsq6jKCpyJayYPYnfqsdA")
    }
    static let mock = AuthResponse(
        id: "23817669-18cc-4402-9707-7a49f93cbe25",
        avatar: "https://news-feed.dunice-testing.com/api/v1/file/693d86bf-fedd-47e8-8f00-332780ab46b8.",
        email: "bla@bla.com",
        name: "Blabla",
        role: "user",
        token: "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyMzgxNzY2OS0xOGNjLTQ0MDItOTcwNy03YTQ5ZjkzY2JlMjUiLCJleHAiOjE2NTQ2NDY0MDB9.KhYE75Zsq4Xj6kdFHewJ1NABIdkdDFX5z6MeppB05rkmaayB9Jl9AfZN3TKOo_giBMsq6jKCpyJayYPYnfqsdA")
    #endif
}

extension AuthResponse: Decodable {
    
    enum RootCodingKeys: String, CodingKey {
        case data
    }
    
    enum DataCodingKeys: String, CodingKey {
        case id, avatar, email, name, role, token
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        let data = try container.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .data)
        id = try data.decode(String.self, forKey: .id)
        avatar = try data.decode(String.self, forKey: .avatar)
        email = try data.decode(String.self, forKey: .email)
        name = try data.decode(String.self, forKey: .name)
        role = try data.decode(String.self, forKey: .role)
        token = try data.decode(String.self, forKey: .token)
    }
}
