//
//  TokenData.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/03.
//

import Foundation
//"result": {
//  "grantType": "bearer",
//  "accessToken":
//  "refreshToken":
//  "accessTokenExpiresIn": 1645603148375
//}

struct TokenData: Codable {
    let grantType, accessToken, refreshToken: String
    let accessTokenExpiresIn: Int
}

