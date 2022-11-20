//
//  SeeAllCollectionViewCell.swift
//  LOOP Movies
//
//  Created by SIMON on 16/11/22.
//

import Foundation
import Foundation
import UIKit

class SeeAllCollectionViewCell : UICollectionViewCell
{
    let showAllButton = UIButton()
    let showAllLabel = UILabel()
    let showAllArrowImage = UIImageView()
    weak var viewDelegate : CollectionViewCellDelegate?
    {
        didSet
        {
            setupViews()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("Class SeeAllCollectionViewCell init/deinit +")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        print("Class SeeAllCollectionViewCell init/deinit -")
    }
    
    func setupViews()
    {
        backgroundColor = .clear
        
        self.contentView.addSubview(showAllButton)
        showAllButton.addTarget(self, action: #selector(openSearchView), for: .touchUpInside)
        showAllButton.backgroundColor = .white
        showAllButton.layer.cornerRadius = 17.5
        
        showAllButton.addSubview(showAllLabel)
        showAllLabel.text = "See All"
        showAllLabel.textColor = .black
        showAllLabel.textAlignment = .center
        
        showAllButton.addSubview(showAllArrowImage)
        showAllArrowImage.image = Appearance.shared.images.showAllArrow
        showAllArrowImage.contentMode = .scaleToFill
        
        addLayoutConstraints()
    }
    func addLayoutConstraints()
    {
        
        showAllButton.translatesAutoresizingMaskIntoConstraints = false
        showAllButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50).isActive = true
        showAllButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        showAllButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        showAllButton.widthAnchor.constraint(equalToConstant: 112).isActive = true
        
        showAllLabel.translatesAutoresizingMaskIntoConstraints = false
        showAllLabel.leadingAnchor.constraint(equalTo: showAllButton.leadingAnchor, constant: 0).isActive = true
        showAllLabel.centerYAnchor.constraint(equalTo: showAllButton.centerYAnchor, constant: 0).isActive = true
        showAllLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        showAllLabel.trailingAnchor.constraint(equalTo: showAllArrowImage.leadingAnchor, constant: -6).isActive = true
        
        showAllArrowImage.translatesAutoresizingMaskIntoConstraints = false
        showAllArrowImage.centerYAnchor.constraint(equalTo: showAllButton.centerYAnchor, constant: 0).isActive = true
        showAllArrowImage.heightAnchor.constraint(equalToConstant: 13).isActive = true
        showAllArrowImage.widthAnchor.constraint(equalToConstant: 13).isActive = true
        showAllArrowImage.trailingAnchor.constraint(equalTo: showAllButton.trailingAnchor, constant: -13).isActive = true
    }
       
    @objc func openSearchView()
    {
        viewDelegate!.openSearchView(type : .FAVORITES)
    }
}
