//
//  ReadCommentsCell.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/08/22.
//

import Foundation
import UIKit

class ReadCommentsCell : UITableViewCell {
    static let identifier = "ReadCommentsCell"
    static func nib() -> UINib {
        return UINib(nibName: "ReadCommentsCell", bundle: nil)
    }
    var index = 0
    var heartIndex = 0
    var isEnabled : Bool = false
    
    enum hexColor {
        case backgroundColor
        case whoseCommentLabelColor
        case commentContentLabelColor
        case reportButtonColor
        case blockButtonColor
        
        func getHexColor() -> UIColor {
            switch self {
            case .backgroundColor:
                return UIColor(hex: 0xF8F4EF)
            case .whoseCommentLabelColor:
                return UIColor(hex: 0x73BF90)
            case .commentContentLabelColor:
                return UIColor(hex: 0x4E4C49)
            case .reportButtonColor:
                return UIColor(hex: 0x878379)
            case .blockButtonColor:
                return UIColor(hex: 0x878379)
            }
        }
    }
    
    
    
    override class func awakeFromNib() {
    super.awakeFromNib()
}
    @IBOutlet weak var commentBackView: UIView!
    @IBOutlet weak var whoseCommentLabel: UILabel!
    @IBOutlet weak var commentContentLabel: UILabel!
    @IBOutlet weak var hearButton: UIButton!
    @IBOutlet weak var blockButton: UIButton!
    @IBOutlet weak var reportButton: UIButton!

    override func layoutSubviews() {
        super.layoutSubviews()
        
        commentBackView.backgroundColor = hexColor.backgroundColor.getHexColor()
        whoseCommentLabel.textColor = hexColor.whoseCommentLabelColor.getHexColor()
        commentContentLabel.textColor = hexColor.whoseCommentLabelColor.getHexColor()
        blockButton.setTitleColor(hexColor.blockButtonColor.getHexColor(), for: .normal)
        blockButton.setTitleColor(hexColor.blockButtonColor.getHexColor(), for: .highlighted)
        reportButton.setTitleColor(hexColor.reportButtonColor.getHexColor(), for: .normal)
        reportButton.setTitleColor(hexColor.reportButtonColor.getHexColor(), for: .highlighted)
        
        commentBackView.layer.cornerRadius = 10
        contentView.backgroundColor = .clear
        
    }
}
