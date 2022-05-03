//
//  TokenRefreshResponse.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/10.
//

import Foundation
struct TokenRefreshResponse: Decodable {
    var code: Int?
    var message: String?
    var result: tokenRefreshResult?
}

struct tokenRefreshResult : Decodable {
    var grantType : String?
    var accessToken : String?
    var refreshToken : String?
    var accessTokenExpiresIn: Int?
    //
    //
}


