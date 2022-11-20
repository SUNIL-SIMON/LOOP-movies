//
//  Appearance.swift
//  LOOP Movies
//
//  Created by SIMON on 17/11/22.
//

import Foundation
import UIKit
public class Appearance {
    public static var shared = Appearance()
    public var color : ColorsProtocol = DefaultThemeColors()
    public var images : ImagesProtocol = DefaultThemeImages()
}


