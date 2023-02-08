//
//  SettingListCell.swift
//  MorningBearUI
//
//  Created by 이영빈 on 2023/02/08.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

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
    
    public func prepare(_ data: Accessory) {
        let config = data.configuration(frame: self.frame)
        
        titleLabel.text = config.label
        self.accessories = [config.accessory].compactMap({$0})
        self.action = config.accessoryAction
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellAction)))
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
    struct AccessoryConfiguration {
        let label: String
        let accessory: UICellAccessory?
        let accessoryAction: () -> Void
    }
    
    enum Accessory {
        public typealias Action = () -> Void
        
        case toggle(label: String, action: Action)
        case navigate(label: String, action: Action)
        case plain(label: String, action: Action)
        
        func configuration(frame: CGRect) -> AccessoryConfiguration {
            switch self {
            case .toggle(let label, let action):
                let config = AccessoryConfiguration(
                    label: label,
                    accessory: .customView(
                        configuration: UICellAccessory.CustomViewConfiguration(customView: controlSwitch(frame: frame), placement: .trailing())
                    ),
                    accessoryAction: action
                )
                return config
            case .navigate(let label, let action):
                return AccessoryConfiguration(label: label, accessory: .disclosureIndicator(), accessoryAction: action)
            case .plain(let label, let action):
                return AccessoryConfiguration(label: label, accessory: nil, accessoryAction: action)
            }
        }
        
        func controlSwitch(frame: CGRect) -> UISwitch {
            let swicth: UISwitch = UISwitch()
            swicth.layer.position = CGPoint(x: frame.width/2, y: frame.height - 200)
            swicth.tintColor = UIColor.orange
            swicth.isOn = true
            
            return swicth
        }
    }
}
