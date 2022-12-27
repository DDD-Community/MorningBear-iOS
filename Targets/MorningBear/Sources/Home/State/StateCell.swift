//
//  StateViewCell.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

class StateCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var badgeLabel: UILabel!
    
    @IBOutlet weak var conditionStackView: UIStackView! {
        didSet {
            conditionStackView.distribution = .equalSpacing
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(state: nil)
    }
    
    func prepare(state: State?) {
        self.titleLabel.text = state?.nickname
    }
}
