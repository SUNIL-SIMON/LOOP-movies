//
//  CrewCollectionViewCell.swift
//  LOOP Movies
//
//  Created by SIMON on 17/11/22.
//

import Foundation
import UIKit
protocol CrewCollectionViewCellDelegate : NSObject
{
    func getPicture(url : String, completion : @escaping(PicturesType)->Void)
    func getCastList()->[CastType]
}
class CrewCollectionViewCell : UICollectionViewCell
{
    var castDetails = CastType(name: "", pictureURL: "", character: "")
    let crewImageView = UIImageView()
    let characterLabel = CaptionLabel(color: Appearance.shared.color.mediumEmphasis_Light)
    let castLabel = UILabel()
    let shadowLayerView = UIView()
    weak var viewDelegate : CrewCollectionViewCellDelegate?
    {
        didSet
        {
            setupViews()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("Class CrewCollectionViewCell init/deinit +")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        print("Class CrewCollectionViewCell init/deinit -")
    }
    
    func setupViews()
    {
        backgroundColor = .clear
        
        self.contentView.addSubview(shadowLayerView)
        shadowLayerView.backgroundColor = .white
        shadowLayerView.dropShadow(opacity: 0.8, shadowRadius: 10)
        
        self.contentView.addSubview(crewImageView)
        crewImageView.backgroundColor = .white
        crewImageView.contentMode = .scaleToFill
        crewImageView.layer.cornerRadius = 10
        crewImageView.layer.masksToBounds = true
        
        crewImageView.addSubview(characterLabel)
        characterLabel.numberOfLines = 0
        crewImageView.addSubview(castLabel)
        castLabel.numberOfLines = 0
        castLabel.textColor = .white
        castLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        
        addLayoutConstraints()
    }
    func addLayoutConstraints()
    {
        shadowLayerView.translatesAutoresizingMaskIntoConstraints = false
        shadowLayerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 25).isActive = true
        shadowLayerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 40).isActive = true
        shadowLayerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -25).isActive = true
        shadowLayerView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        crewImageView.translatesAutoresizingMaskIntoConstraints = false
        crewImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        crewImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30).isActive = true
        crewImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20).isActive = true
        crewImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        characterLabel.translatesAutoresizingMaskIntoConstraints = false
        characterLabel.trailingAnchor.constraint(equalTo: crewImageView.trailingAnchor, constant: -8).isActive = true
        characterLabel.leadingAnchor.constraint(equalTo: crewImageView.leadingAnchor, constant: 8).isActive = true
        characterLabel.bottomAnchor.constraint(equalTo: crewImageView.bottomAnchor, constant: -8).isActive = true
        
        castLabel.translatesAutoresizingMaskIntoConstraints = false
        castLabel.trailingAnchor.constraint(equalTo: crewImageView.trailingAnchor, constant: -8).isActive = true
        castLabel.leadingAnchor.constraint(equalTo: crewImageView.leadingAnchor, constant: 8).isActive = true
        castLabel.bottomAnchor.constraint(equalTo: characterLabel.topAnchor, constant: 2).isActive = true
        
    }
    func updateCell(cast : CastType)
    {
        castDetails = cast
        characterLabel.text = cast.character
        castLabel.text = cast.name
        self.crewImageView.image = nil
        viewDelegate?.getPicture(url: castDetails.pictureURL, completion: {(picture) in
            DispatchQueue.main.async {
                if picture.url == self.castDetails.pictureURL
                {
                    self.crewImageView.image = picture.image!
                }
            }
        })
    }
    
}
