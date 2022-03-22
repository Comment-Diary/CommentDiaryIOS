//
//  HeartBtn.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/22.
//

import Foundation
import UIKit

class HeartBtn: UIButton {
    var isActivated : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setState(_ newValue: Bool) {
        print("HeartBtn - setState() called / newValue: \(newValue)")
        // 1. 현재 버튼 상태 변경
        self.isActivated = newValue
        
        let activatedImage = UIImage(named: "customHeartFill")
        let normalImage = UIImage(named: "customHeart")
        
        self.setImage(self.isActivated ? activatedImage: normalImage, for: .normal)
    }
}
