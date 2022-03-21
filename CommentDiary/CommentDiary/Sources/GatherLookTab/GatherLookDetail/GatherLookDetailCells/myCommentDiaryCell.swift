//
//  myCommentDiaryCell.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/20.
//

import UIKit

class myCommentDiaryCell: UITableViewCell {
    
    static let identifier = "myCommentDiaryCell"
    static func nib() -> UINib {
        return UINib(nibName: "myCommentDiaryCell", bundle: nil)
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var separateView: UIView!
    
    @IBOutlet weak var contentVIew: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dateLabel.textColor = UIColor(hex: 0xFFAC86)
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        titleLabel.font = UIFont.AppleSDGothic(.bold, size: 21)
        titleLabel.textColor = UIColor(hex: 0x4E4C49)
        separateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        contentVIew.textColor = UIColor(hex: 0x4E4C49)
        contentVIew.font = UIFont.AppleSDGothic(.medium, size: 15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = UIColor(hex: 0xFDFCF9)
        contentView.layer.cornerRadius = 8
        
        contentView.clipsToBounds = false
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 60, left: 0, bottom: 60, right: 0))
    }
    
    
}
