//
//  SentCommentListResponse.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/13.
//

import Foundation
struct SentCommentListResponse: Decodable {
    let code: Int?
    let message: String?
    let result: [sentCommentListResult]?
}

// MARK: - Result
struct sentCommentListResult: Decodable {
    let id: Int?
    let content: String?
    let date: String?
    let like: Bool?
    
}
