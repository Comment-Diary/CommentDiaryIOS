//
//  PasswordSentAlertService.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/23.
//

import Foundation
import UIKit

class FailFindPasswordAlertService {
    func alert() -> FailFindPasswordViewController {
        let storyboard = UIStoryboard(name: "FailFIndPassword", bundle: .main)
        let failFindPasswordVC = storyboard.instantiateViewController(withIdentifier: "FailFindPasswordViewController") as! FailFindPasswordViewController
        return failFindPasswordVC
    }
}
