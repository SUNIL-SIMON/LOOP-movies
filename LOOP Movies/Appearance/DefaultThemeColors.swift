//
//  DefaultThemeColors.swift
//  LOOP Movies
//
//  Created by SIMON on 17/11/22.
//

import Foundation
import UIKit
public class DefaultThemeColors : ColorsProtocol {
    public var backgroundColor : UIColor
    public var titleColor : UIColor
    public var elevatedColor : UIColor
    public var veryLowEmphasis : UIColor
    public var highEmphasis_Light : UIColor
    public var mediumEmphasis_Light : UIColor
    public var highEmphasis : UIColor
    public var mediumEmphasis : UIColor
    public var lowEmphasis_Light : UIColor
    init()
    {
        backgroundColor = UIColor.init(named: "BackgroudColor")!
        titleColor = UIColor.init(named: "TitleColor")!
        elevatedColor = UIColor.init(named: "Elevated")!
        veryLowEmphasis = UIColor.init(named: "VeryLowEmphasis")!
        highEmphasis_Light = UIColor.init(named: "HighEmphasis_Light")!
        mediumEmphasis_Light = UIColor.init(named: "MediumEmphasis_Light")!
        highEmphasis = UIColor.init(named: "HighEmphasis")!
        mediumEmphasis = UIColor.init(named: "MediumEmphasis")!
        lowEmphasis_Light = UIColor.init(named: "LowEmphasis_Light")!
    }

}
