//
//  EmptyStateView.swift
//  LOOP Movies
//
//  Created by SIMON on 17/11/22.
//

import Foundation
import UIKit
class EmptyStateView : UIView
{
    let emptyImageView = UIImageView()
    let emptyLabel = UILabel()
    init()
    {
        print("Class RatingsFilterButton init/deinit +")
        super.init(frame: .zero)
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit
    {
        print("Class RatingsFilterButton init/deinit -")
    }
    func setupViews()
    {
        self.addSubview(emptyImageView)
        emptyImageView.image = Appearance.shared.images.emptyImage
        emptyImageView.contentMode = .scaleToFill
        
        self.addSubview(emptyLabel)
        emptyLabel.textAlignment = .center
        emptyLabel.text = "No Movies found 😞"
        emptyLabel.textColor = .white
        
        addLayoutConstraints()
    }
    func addLayoutConstraints()
    {
        
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        emptyImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        emptyImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        emptyImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        emptyImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.topAnchor.constraint(equalTo: emptyImageView.bottomAnchor, constant: 30).isActive = true
        emptyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        emptyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        emptyLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
