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
        self.prepareCell(title: nil, buttonText: nil, buttonAction: nil)
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.prepareCell(title: nil, buttonText: nil, buttonAction: nil)
    }
}

// MARK: Public tools
extension HomeSectionHeaderCell {
    /// 버튼이 사용가능한지 표시
    public var isButtonDisabled: Bool {
        return needsButton == false
    }
    
    public func prepare(title: String) {
        prepareCell(title: title, buttonText: nil, buttonAction: nil)
    }
    
    public func prepare(title: String, buttonText: String, buttonAction: @escaping Action) {
        prepareCell(title: title, buttonText: buttonText, buttonAction: buttonAction)
    }
}

// MARK: Interanal tools
extension HomeSectionHeaderCell {
    /// 초기화도 가능한 내부용 `prepare`
    ///
    /// `prepare`로 작명하지 않은 이유는 퍼블릭 메소드와 이름이 같아서 무한히 순환참조하는 에러가 발생해서임
    private func prepareCell(title: String?, buttonText: String?, buttonAction: Action? = nil) {
        // 액션이 없으면 버튼은 표시되지 않음
        if let buttonAction {
            self.needsButton = true
            self.buttonAction = buttonAction
        } else {
            self.needsButton = false
            self.buttonAction = {}
        }
        
        self.titleLabel.text = title
        self.moreButton.setTitle(buttonText, for: .normal)
        
        bindButton()
    }
    
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