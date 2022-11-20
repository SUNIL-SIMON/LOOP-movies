//
//  FavoritesTableViewCell.swift
//  LOOP Movies
//
//  Created by SIMON on 16/11/22.
//

import Foundation
import UIKit
class FavoritesTableViewCell : UITableViewCell
{
    let favoritesCollectionView = FavoritesCollectionView()
    var favoritesLabel = HomeSectionLabel.init(string1: "YOUR", string2: " FAVORITES", color: Appearance.shared.color.highEmphasis)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("Class FavoritesTableViewCell init/deinit +")
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        print("Class FavoritesTableViewCell init/deinit -")
    }
    
    func setupViews()
    {
        backgroundColor = .clear
        
        self.contentView.addSubview(favoritesLabel)
//        favoritesLabel.text = "YOUR FAVORITES"
//        favoritesLabel.textColor = .black
        
        self.contentView.addSubview(favoritesCollectionView)
        
        addLayoutConstraints()
    }
    func addLayoutConstraints()
    {
       
        
        favoritesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        favoritesCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        favoritesCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        favoritesCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        favoritesCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        favoritesLabel.translatesAutoresizingMaskIntoConstraints = false
        favoritesLabel.bottomAnchor.constraint(equalTo: self.favoritesCollectionView.topAnchor, constant: 0).isActive = true
        favoritesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        favoritesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        favoritesLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
