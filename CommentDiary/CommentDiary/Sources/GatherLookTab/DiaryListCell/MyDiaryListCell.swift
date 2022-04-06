//
//  MyDiaryListCell.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/12.
//

import UIKit

class MyDiaryListCell: UITableViewCell {
    
    var selectedId : Int = 0
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var commentCountBackView: UIView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var commentCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dateLabel.textColor = UIColor(hex: 0xFFAC86)
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        titleLabel.textColor = UIColor(hex: 0x4E4C49)
        titleLabel.font = UIFont.AppleSDGothic(.bold, size: 18)
        contentLabel.textColor = UIColor(hex: 0x4E4C49)
        contentLabel.font = UIFont.AppleSDGothic(.medium, size: 14)
        commentCountLabel.textColor = UIColor(hex: 0xFDFCF9)
        commentCountLabel.font = UIFont.AppleSDGothic(.bold, size: 13)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.layer.cornerRadius = 10
//        contentView.layer.borderWidth = 30
        contentView.backgroundColor = UIColor(hex: 0xFDFCF9)
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 17, bottom: 0, right: 17))
        
    }

}
