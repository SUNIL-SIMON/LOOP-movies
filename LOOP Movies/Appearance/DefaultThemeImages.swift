//
//  DefaultThemeImages.swift
//  LOOP Movies
//
//  Created by SIMON on 17/11/22.
//

import Foundation
import UIKit
public class DefaultThemeImages : ImagesProtocol {
    public var backgroundImage: UIImage
    public var highlightedStar : UIImage
    public var unHighlightedStar : UIImage
    public var arrowBack : UIImage
    public var bookMarkBaseImage : UIImage
    public var highlightedBookMark : UIImage
    public var showAllArrow : UIImage
    public var searchGlass : UIImage
    public var unHighlightedLowEmphasisStar : UIImage
    public var unhighlightedHighEmphasisStar : UIImage
    public var closeImage : UIImage
    public var bookMarkDark : UIImage
    public var emptyImage : UIImage
    init()
    {
        backgroundImage = UIImage(named: "HomeBackground")!
        highlightedStar = UIImage(named: "HighlightedStar")!
        unHighlightedStar = UIImage(named: "UnHighlightedStar")!
        arrowBack = UIImage(named: "ArrowBack")!
        bookMarkBaseImage = UIImage(named: "BookMarkBaseImage")!
        highlightedBookMark = UIImage(named: "HighlightedBookMark")!
        showAllArrow = UIImage(named: "ShowAllArrow")!
        searchGlass = UIImage(named: "SearchGlass")!
        unHighlightedLowEmphasisStar = UIImage(named: "unHighlightedLowEmphasisStar")!
        unhighlightedHighEmphasisStar = UIImage(named: "UnhighlightedHighEmphasisStar")!
        closeImage = UIImage(named: "Close")!
        bookMarkDark = UIImage(named: "BookMarkDark")!
        emptyImage = UIImage(named: "EmptyImage")!
        
    }

}
