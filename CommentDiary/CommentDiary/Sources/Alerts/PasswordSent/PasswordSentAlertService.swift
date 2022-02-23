//
//  PasswordSentAlertService.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/23.
//

import Foundation
import UIKit

class PasswordSentAlertService {
    func alert() -> PasswordSentAlertViewController {
        let storyboard = UIStoryboard(name: "PasswordSentAlert", bundle: .main)
        let passwordSentAlertVC = storyboard.instantiateViewController(withIdentifier: "PasswordSentAlertViewController") as! PasswordSentAlertViewController
        return passwordSentAlertVC
    }
}
