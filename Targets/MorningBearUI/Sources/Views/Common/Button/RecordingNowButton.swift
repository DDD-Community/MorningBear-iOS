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

    private let bag = DisposeBag()
    private var buttonAction: Action?
    
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
    @IBOutlet weak var stopButton: UIButton! {
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
        bindButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadXib()
        bindButton()
    }
}

private extension RecordingNowButton {
    func bindButton() {
        stopButton.rx.tap.bind { [weak self] in
            guard let self else { return }
            
            self.buttonAction?()
        }
        .disposed(by: bag)
    }
}

public extension RecordingNowButton {
    func prepare(time: String) {
        timeLabel.text = time
    }
    
    func prepare(action: @escaping Action) {
        buttonAction = action
    }
}
