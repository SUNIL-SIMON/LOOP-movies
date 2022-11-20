//
//  DataTypes.swift
//  LOOP Movies
//
//  Created by SIMON on 16/11/22.
//

import Foundation
import UIKit
struct MovieDetailsType
{
    var movieID : Int
    var title : String
    var posterURL : String
    var releaseDate : String
    var rating : CGFloat
    var genres : [String]
    var director : DirectorType
    var cast : [CastType]
    var overview : String
    var budget : Double
    var language : String
    var revenue : Double
    var reviews : Int
    var runningTime : Int
    var bookMarked : Bool
}
struct DirectorType
{
    var name : String
    var pictureURL : String
}
struct CastType{
    var name : String
    var pictureURL : String
    var character : String
}
struct PicturesType
{
    var url : String
    var image : UIImage?
}
enum RatingFilterType
{
    case _1Star
    case _2Star
    case _3Star
    case _4Star
    case _5Star
    case _All
}
enum SearchType
{
    case ALLMOVIES
    case FAVORITES
}
