//
//  ColorsProtocol.swift
//  LOOP Movies
//
//  Created by SIMON on 17/11/22.
//

import Foundation
import UIKit
public protocol ColorsProtocol {
    var backgroundColor : UIColor { get }
    var titleColor : UIColor { get }
    var elevatedColor : UIColor { get }
    var veryLowEmphasis : UIColor { get }
    var highEmphasis_Light : UIColor { get }
    var mediumEmphasis_Light : UIColor { get }
    var highEmphasis : UIColor { get }
    var mediumEmphasis : UIColor { get }
    var lowEmphasis_Light : UIColor { get }
}
