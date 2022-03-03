//
//  TokenData.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/03.
//

import Foundation
struct TokenData: Codable {
    var grantType: String = ""
    var accessToken: String
    var refreshToken: String
    var accessTokenExpiresIn : Int = 0
}
