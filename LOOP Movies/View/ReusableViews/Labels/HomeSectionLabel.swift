//
//  HomeSectionLabel.swift
//  LOOP Movies
//
//  Created by SIMON on 17/11/22.
//

import Foundation
import UIKit
class HomeSectionLabel : UILabel
{
    init(string1 : String, string2 : String, color : UIColor) {
        super.init(frame: .zero)
        setupProperties(string1: string1, string2: string2, color : color)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        
    }
    
    func setupProperties(string1 : String, string2 : String, color : UIColor)
    {

        let myAttribute1 = [ NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        let myAttrString1 = NSMutableAttributedString(string: string1, attributes: myAttribute1)
        
        let myAttribute2 = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .bold)]
        let myAttrString2 = NSMutableAttributedString(string: string2, attributes: myAttribute2)
        
        let combination = NSMutableAttributedString()
        combination.append(myAttrString1)
        combination.append(myAttrString2)
        self.attributedText = combination
    }
}


