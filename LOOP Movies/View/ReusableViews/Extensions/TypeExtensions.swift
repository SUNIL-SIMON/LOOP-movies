//
//  TypeExtensions.swift
//  LOOP Movies
//
//  Created by SIMON on 17/11/22.
//

import Foundation
import UIKit
extension String
{
    func getYear()->String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else { return self }
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    func getDateAndRunTime(runningHours : Int)->String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else { return self }
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let hours = runningHours / 60
        let min = (runningHours % 60)
        
        return "\(dateFormatter.string(from: date)) . \(hours)h \(min)m"
    }
}
extension CGFloat {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
