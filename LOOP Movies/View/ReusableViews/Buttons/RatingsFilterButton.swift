//
//  RatingsFilterButton.swift
//  LOOP Movies
//
//  Created by SIMON on 17/11/22.
//

import Foundation
import UIKit
class RatingsFilterButton : UIButton
{
    let baseView = UIView()
    var ratingsViewArray : [UIImageView] = []
    init(ratingCount : Int)
    {
        print("Class RatingsFilterButton init/deinit +")
        super.init(frame: .zero)
        setupViews(ratingCount: ratingCount)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit
    {
        print("Class RatingsFilterButton init/deinit -")
    }
    func setupViews(ratingCount : Int)
    {
        backgroundColor = Appearance.shared.color.backgroundColor
        self.layer.cornerRadius = 15
        self.layer.borderColor = Appearance.shared.color.highEmphasis_Light.cgColor
        self.layer.borderWidth = 0.5
        
        self.addSubview(baseView)
        baseView.backgroundColor = .clear
        
        for _ in 0..<ratingCount
        {
            let star = UIImageView()
            star.image = Appearance.shared.images.unhighlightedHighEmphasisStar
            ratingsViewArray.append(star)
            self.baseView.addSubview(star)
        }
        baseView.isUserInteractionEnabled = false
        
        addLayoutConstraints()
    }
    func addLayoutConstraints()
    {
        
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        baseView.heightAnchor.constraint(equalToConstant: 9).isActive = true
        
        for i in 0..<ratingsViewArray.count
        {
            let star = ratingsViewArray[i]
            star.translatesAutoresizingMaskIntoConstraints = false
            star.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 0).isActive = true
            star.leadingAnchor.constraint(equalTo: i == 0 ? baseView.leadingAnchor : ratingsViewArray[i - 1].trailingAnchor, constant: i == 0 ? 0 : 2).isActive = true
            star.heightAnchor.constraint(equalToConstant: 9).isActive = true
            star.widthAnchor.constraint(equalToConstant: 9).isActive = true
        }
        
    }
    func set(selected : Bool)
    {
        for i in 0..<ratingsViewArray.count
        {
            ratingsViewArray[i].image = ((selected) ? Appearance.shared.images.highlightedStar : Appearance.shared.images.unhighlightedHighEmphasisStar)
        }
    }
}
