//
//  BodyTitleLabel.swift
//  LOOP Movies
//
//  Created by SIMON on 18/11/22.
//

import Foundation
import UIKit
class BodyTitleLabel : UILabel
{
    init(color: UIColor) {
        super.init(frame: .zero)
        print("Class BodyTitleLabel init/deinit +")
        setupProperties(color: color)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        print("Class BodyTitleLabel init/deinit -")
    }
    
    func setupProperties(color: UIColor)
    {
        self.textColor = color
        self.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
}
