//
//  SendCommentCell.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/12.
//

import UIKit

class SendCommentCell: UITableViewCell {
    
    @IBOutlet weak var contentBackView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var hearyImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dateLabel.textColor = UIColor(hex: 0x73BF90)
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        commentLabel.textColor = UIColor(hex: 0x4E4C49)
        commentLabel.font = UIFont.AppleSDGothic(.medium, size: 14)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        contentBackView.layer.cornerRadius = 10
//        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = UIColor(hex: 0xF4EDE3)
    }
    
}
