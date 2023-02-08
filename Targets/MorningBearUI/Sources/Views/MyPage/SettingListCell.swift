//
//  SettingListCell.swift
//  MorningBearUI
//
//  Created by 이영빈 on 2023/02/08.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

@_exported import MorningBearData

public class SettingListCell: UICollectionViewListCell, CustomCellType {
    public static let filename: String = String(describing: SettingListCell.self)
    public static let reuseIdentifier: String = "SettingListCell"
    public static let bundle: Bundle = MorningBearUIResources.bundle
    
    private var action: (() -> Void)?
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
            titleLabel.textColor = .white
        }
    }
    
    public func prepare(_ data: AccessoryConfiguration) {
        let config = data
        
        titleLabel.text = config.label
        self.accessories = [config.accessory].compactMap({$0})
        self.action = config.accessoryAction
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellAction)))
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.backgroundColor = MorningBearUIAsset.Colors.primaryBackground.color
    }
    
    @objc
    private func cellAction() {
        action?()
    }
    
    private func prepareCell() {
        titleLabel.text = nil
        self.accessories = []
    }
}

public extension SettingListCell {
    
    private func controlSwitch(frame: CGRect) -> UISwitch {
        let swicth: UISwitch = UISwitch()
        swicth.layer.position = CGPoint(x: frame.width/2, y: frame.height - 200)
        swicth.tintColor = UIColor.orange
        swicth.isOn = true
        
        return swicth
    }
}
