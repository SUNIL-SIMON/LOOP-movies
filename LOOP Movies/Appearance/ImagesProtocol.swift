//
//  ImagesProtocol.swift
//  LOOP Movies
//
//  Created by SIMON on 17/11/22.
//

import Foundation
import UIKit
public protocol ImagesProtocol {
    var backgroundImage : UIImage { get }
    var highlightedStar : UIImage { get }
    var unHighlightedStar : UIImage { get }
    var unHighlightedLowEmphasisStar : UIImage { get }
    var arrowBack : UIImage { get }
    var bookMarkBaseImage : UIImage { get }
    var highlightedBookMark : UIImage { get }
    var showAllArrow : UIImage { get }
    var searchGlass : UIImage { get }
    var unhighlightedHighEmphasisStar : UIImage { get }
    var closeImage : UIImage { get }
    var bookMarkDark : UIImage { get }
    var emptyImage : UIImage { get }
    
}
