//
//  BookMarkButton.swift
//  LOOP Movies
//
//  Created by SIMON on 17/11/22.
//

import Foundation
import UIKit
class BookMarkButton : UIButton
{
    var baseImageView = UIImageView()
    var highlightedImageView = UIImageView()
    init(outlineImage: UIImage) {
        super.init(frame: .zero)
        print("Class BookMarkButton init/deinit +")
        setupViews(outlineImage: outlineImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        print("Class BookMarkButton init/deinit -")
    }

    func setupViews(outlineImage: UIImage)
    {
        backgroundColor = .clear
        
        self.addSubview(baseImageView)
        baseImageView.image = outlineImage
        baseImageView.contentMode = .scaleToFill
        
        baseImageView.addSubview(highlightedImageView)
        highlightedImageView.image = Appearance.shared.images.highlightedBookMark
        highlightedImageView.contentMode = .scaleToFill
        
        addLayoutConstraints()
    }
    func addLayoutConstraints()
    {
        
        baseImageView.translatesAutoresizingMaskIntoConstraints = false
        baseImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        baseImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        baseImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        baseImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        highlightedImageView.translatesAutoresizingMaskIntoConstraints = false
        highlightedImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2.5).isActive = true
        highlightedImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2.5).isActive = true
        highlightedImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2.5).isActive = true
        highlightedImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
        
    }
    func set(selected:Bool)
    {
        if selected
        {
            highlightedImageView.isHidden = false
        }
        else{
            highlightedImageView.isHidden = true
        }
    }
}
