//
//  BodySecondaryLabel.swift
//  LOOP Movies
//
//  Created by SIMON on 18/11/22.
//

import Foundation
import UIKit
class BodySecondaryLabel : UILabel
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("Class BodySecondaryLabel init/deinit +")
        setupProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        print("Class BodySecondaryLabel init/deinit -")
    }
    
    func setupProperties()
    {
        self.textColor = Appearance.shared.color.highEmphasis_Light
        self.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
}
