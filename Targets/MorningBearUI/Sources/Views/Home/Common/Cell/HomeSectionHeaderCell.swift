//
//  TitleHeaderViewCell.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

public class HomeSectionHeaderCell: UICollectionViewCell {
    public typealias Action = () -> Void
    
    // View components
    @IBOutlet weak var stackView: UIStackView! {
        didSet {
            stackView.distribution = .equalSpacing
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
        }
    }
    @IBOutlet weak var moreButton: UIButton! {
        didSet {
            moreButton.setTitleColor(MorningBearUIAsset.Colors.captionText.color, for: .normal)
            moreButton.titleLabel?.font = MorningBearUIFontFamily.Pretendard.regular.font(size: 12)
        }
    }
    
    // Internal variables
    private let bag = DisposeBag() // For RxCocoa
    
    /// 버튼 표시를 결정
    private var needsButton = false {
        didSet {
            // 버튼이 필요하면 숨기지 말 것
            moreButton.isHidden = !needsButton
        }
    }
    
    /// 버튼 액션; 기본값으로 아무것도 하지 않음
    private var buttonAction: Action = {}
    
    
    // Methods
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(descText: nil, titleText: nil, buttonAction: nil)
    }
    
    public func prepare(descText: String?, titleText: String?, buttonAction: Action? = nil) {
        // 액션이 없으면 버튼은 표시되지 않음
        if let buttonAction {
            self.needsButton = true
            self.buttonAction = buttonAction
        } else {
            self.needsButton = false
            self.buttonAction = {}
        }
        
        self.titleLabel.text = titleText
        self.moreButton.setTitle(descText, for: .normal)
        
        bindButton()
    }
}

// MARK: Interanal tools
extension HomeSectionHeaderCell {
    private func bindButton() {
        self.moreButton.rx.tap.bind { [weak self] in
            guard let self = self else {
                return
            }
            
            self.buttonAction()
        }
        .disposed(by: bag)
    }
}
