//
//  RecordingNowButton.swift
//  MorningBearUI
//
//  Created by Young Bin on 2023/01/11.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

public class RecordingNowButton: UIView {
    public typealias Action = () -> Void
    
    @IBOutlet var wrapperView: UIView! {
        didSet {
            wrapperView.backgroundColor = .clear
            self.backgroundColor = MorningBearUIAsset.Colors.gray800.color
            self.layer.cornerRadius = 8
        }
    }
    @IBOutlet public weak var timeLabel: UILabel! {
        didSet {
            timeLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
            timeLabel.textColor = .white
        }
    }
    @IBOutlet public weak var stopButton: UIButton! {
        didSet {
            stopButton.setTitle("종료하기", for: .normal)
            stopButton.setTitleColor(.white, for: .normal)
            stopButton.titleLabel?.font = MorningBearUIFontFamily.Pretendard.regular.font(size: 12)
            
            stopButton.backgroundColor = MorningBearUIAsset.Colors.canceledDark.color
            stopButton.layer.cornerRadius = 8
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadXib()
    }
}

public extension RecordingNowButton {
    func prepare(time: String) {
        timeLabel.text = time
    }
}
