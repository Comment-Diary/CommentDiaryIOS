//
//  AuthNumberAlertService.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/17.
//

import Foundation
import UIKit

class AuthNumberAlertService {
    func alert() -> AuthNumberViewController {
        let storyboard = UIStoryboard(name: "AuthNumber", bundle: .main)
        let authNumberVC = storyboard.instantiateViewController(withIdentifier: "AuthNumberViewController") as! AuthNumberViewController
        return authNumberVC
    }
}
