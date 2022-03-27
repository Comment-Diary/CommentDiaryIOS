//
//  LoginResponse.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/21.
//

import Foundation

struct LoginResponse: Codable {
//    var code: Int = 0
    var message: String = ""
    var result: TokenData
}

struct TokenData: Codable {
    var grantType: String = ""
    var accessToken: String
    var refreshToken: String
    var accessTokenExpiresIn : Int = 0
}

