//
//  Color.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/12.
//

import Foundation
import UIKit

extension UIColor {
    // MARK: hex code를 이용하여 정의
    // ex. UIColor(hex: 0xF5663F)
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의
    // ex. label.textColor =  .mainOrange
    class var mainOrange: UIColor { UIColor(hex: 0xF5CDA9) }
    
    class var textColor: UIColor { UIColor(hex: 0x5F5D59)}
    
    class var greenColor : UIColor { UIColor(hex: 0x98C2A8)}
    
    class var mainGreenColor : UIColor { UIColor(hex: 0x73BF90)}
    
    class var mainBackgroundColor : UIColor { UIColor(hex: 0xE5E5E5)}
    
    
    
    //VER2
    class var mainTabBarItemColor: UIColor { UIColor(hex: 0x4E4C49)}
    class var myDiaryMainBackgroundColor: UIColor { UIColor(hex: 0xF5F5F5)}
    class var myDiaryCalendarBorderColor: UIColor { UIColor(hex: 0x5ABD80)}
    class var myDiaryCalendarBackgroundColor : UIColor { UIColor(hex: 0xFDFCF9)}
  
}
