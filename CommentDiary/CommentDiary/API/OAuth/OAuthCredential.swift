//
//  OAuthCredential.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/03.
//

import Foundation
import Alamofire

struct OAuthCredential: AuthenticationCredential {
    
    let accessToken: String
    
    let refreshToken: String
    
    let expiration: Date
    
    // Require refresh if within 5 minutes of expiration
    var requiresRefresh: Bool { Date(timeIntervalSinceNow: 30) > expiration }
    
    
}
