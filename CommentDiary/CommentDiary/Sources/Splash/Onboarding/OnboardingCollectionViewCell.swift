//
//  OnboardingCollectionViewCell.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/16.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    @IBOutlet weak var slideImageView: UIImageView!
    
    func setup(_ slide: OnboardingSlide) {
        slideImageView.image = slide.image
    }
}
