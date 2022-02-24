//
//  LoginResponse.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/21.
//

import Foundation

struct LoginResponse: Decodable {
    var code: Int
    var message: String
    var result: result
}

struct result: Decodable {
    var grantType: String
    var accessToken: String
    var refreshToken: String
    var accessTokenExpiresIn : Int
}

struct LoginSuccessReponse {
    static var ResponseState = false
}
