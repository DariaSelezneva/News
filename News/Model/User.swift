//
//  User.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation

struct User {
    
    var id: String
    var avatar: String
    var email: String
    var name: String
    var role: String
    
}

extension User: Decodable {}

extension User: Encodable {
    
    enum EncodingKeys: String, CodingKey {
        case avatar, email, name, role
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodingKeys.self)
        try container.encode(avatar, forKey: .avatar)
        try container.encode(email, forKey: .email)
        try container.encode(name, forKey: .name)
        try container.encode(role, forKey: .role)
    }
}

let user1 = """
"SUCCESS: {
data =     {
    avatar = "https://news-feed.dunice-testing.com/api/v1/file/502f5549-98ad-4db5-903b-c8d445bd4369.";
    email = "example1@bla.com";
    id = "06efea59-f79e-4e1b-9847-bcdd0d5d4470";
    name = NewUser;
    role = user;
    token = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIwNmVmZWE1OS1mNzllLTRlMWItOTg0Ny1iY2RkMGQ1ZDQ0NzAiLCJleHAiOjE2NTM0MzY4MDB9.ypebQO9lStFm68WiitvhmV48QsXw9B6pSAF5AemhPDoopgnsepkBUrCVLzQ_blGDV7ERBHS62aDo6iKrLUderg";
};
statusCode = 1;
success = 1;
}
"""

let user3 = UserResponse(id: "00e28d06-14ea-4f12-b559-6a3f029da40e", avatar: "https://news-feed.dunice-testing.com/api/v1/file/502f5549-98ad-4db5-903b-c8d445bd4369.", email: "example3@bla.com", name: "NewUser", role: "user")
let token3 = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIwMGUyOGQwNi0xNGVhLTRmMTItYjU1OS02YTNmMDI5ZGE0MGUiLCJleHAiOjE2NTM0MzY4MDB9.ALjGxJQstnOiCV-dSk42WjMm54TuV1iAN9KhWhndIDmrcTPA16WRWvSLT-BNL3jQPNk_4_qAH5wNhJbDM9ZYqA"
