//
//  TokenRefreshResponse.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/10.
//

import Foundation
struct TokenRefreshResponse: Codable {
    var code: Int
    var message: String
    var result: tokenRefreshResult
}

struct tokenRefreshResult : Codable {
    var grantType : String
    var accessToken : String
    var refreshToken : String
    var accessTokenExpiresIn: Int
}


