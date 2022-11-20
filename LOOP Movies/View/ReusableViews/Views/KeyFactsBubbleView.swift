//
//  KeyFactsBubbleView.swift
//  LOOP Movies
//
//  Created by SIMON on 17/11/22.
//

import Foundation
import UIKit
class KeyFactsBubbleView : UIView
{
    var titleLabel = CaptionLabel(color: Appearance.shared.color.mediumEmphasis)
    var valueLabel = BodyLabel(color: .black)
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("Class KeyFactsBubbleView init/deinit +")
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        print("Class KeyFactsBubbleView init/deinit -")
    }
    
    func setupViews()
    {
        self.layer.cornerRadius = 10
        self.backgroundColor = Appearance.shared.color.veryLowEmphasis
        
        self.addSubview(titleLabel)
        
        self.addSubview(valueLabel)
        
        addLayoutConstraints()
    }
    func addLayoutConstraints()
    {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        valueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        valueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        valueLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    func set(title : String, value : String)
    {
        titleLabel.text = title
        valueLabel.text = value
    }
}
