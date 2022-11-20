//
//  SearchTableViewCell.swift
//  LOOP Movies
//
//  Created by SIMON on 16/11/22.
//

import Foundation
import UIKit
class SearchTableViewCell : UITableViewCell
{
    let lookInGlassButton = UIButton()
    weak var viewDelegate : CollectionViewCellDelegate?
    {
        didSet
        {
            setupViews()
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("Class SearchTableViewCell init/deinit +")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        print("Class SearchTableViewCell init/deinit -")
    }
    
    func setupViews()
    {
        backgroundColor = .clear
        
        self.contentView.addSubview(lookInGlassButton)
        lookInGlassButton.setImage(Appearance.shared.images.searchGlass, for: .normal)
        lookInGlassButton.backgroundColor = .white
        lookInGlassButton.layer.cornerRadius = 10
        lookInGlassButton.layer.masksToBounds = true
        lookInGlassButton.dropShadow(opacity: 0.2, shadowRadius: 15)
        lookInGlassButton.addTarget(self, action: #selector(openSearchView), for: .touchUpInside)

        addLayoutConstraints()
    }
    func addLayoutConstraints()
    {
        
        lookInGlassButton.translatesAutoresizingMaskIntoConstraints = false
        lookInGlassButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30).isActive = true
        lookInGlassButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -6).isActive = true
        lookInGlassButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        lookInGlassButton.widthAnchor.constraint(equalToConstant: 48).isActive = true

        
    }
       
    @objc func openSearchView()
    {
        viewDelegate!.openSearchView(type : .ALLMOVIES)
    }

}
