//
//  BackgroundReusableView.swift
//  MorningBearUI
//
//  Created by Young Bin on 2023/02/06.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

public class BackgroundReusableView: UICollectionReusableView {
    @IBOutlet weak var backgroundView: UIView! {
        didSet {
            backgroundView.layer.cornerRadius = 8
            backgroundView.backgroundColor = MorningBearUIAsset.Colors.gray900.color
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let identifier = String(describing: type(of: self))
        let nibs = MorningBearUIResources.bundle.loadNibNamed(identifier, owner: self, options: nil)
        
        guard let customView = nibs?.first as? UIView else { return }
        customView.frame = self.bounds
        
        self.addSubview(customView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 8
        backgroundColor = .clear
    }
}
