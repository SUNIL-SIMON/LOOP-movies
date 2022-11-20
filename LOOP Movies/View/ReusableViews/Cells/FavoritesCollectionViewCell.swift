//
//  FavoritesCollectionViewCell.swift
//  LOOP Movies
//
//  Created by SIMON on 16/11/22.
//

import Foundation
import UIKit
protocol CollectionViewCellDelegate : NSObject
{
    func getMoviesList(rating : [RatingFilterType], searchText : String, type : SearchType)->[MovieDetailsType]
    func getPicture(url : String, completion : @escaping(PicturesType)->Void)
    func openSearchView(type : SearchType)
    func openDetailsView(movie:MovieDetailsType)
}
class FavoritesCollectionViewCell : UICollectionViewCell
{
    
    let posterImageButton = UIButton()
    let shadowLayerView = UIView()
    var movieDetails = MovieDetailsType(movieID: 0, title: "", posterURL: "", releaseDate: "", rating: 0, genres: [], director: DirectorType(name: "", pictureURL: ""),cast: [],overview: "",budget: 0,language: "",revenue: 0,reviews: 0, runningTime: 0, bookMarked: false)
    weak var viewDelegate : CollectionViewCellDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("Class FavoritesCollectionViewCell init/deinit +")
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        print("Class FavoritesCollectionViewCell init/deinit -")
    }
    
    func setupViews()
    {
        backgroundColor = .clear
        
        self.contentView.addSubview(shadowLayerView)
        shadowLayerView.backgroundColor = .white
        shadowLayerView.dropShadow(opacity: 0.7, shadowRadius: 15)
        
        self.contentView.addSubview(posterImageButton)
        posterImageButton.layer.cornerRadius = 10
        posterImageButton.layer.masksToBounds = true
        posterImageButton.backgroundColor = .white
        posterImageButton.addTarget(self, action: #selector(openDetailsView), for: .touchUpInside)
        
        
        addLayoutConstraints()
    }
    func addLayoutConstraints()
    {
        
        shadowLayerView.translatesAutoresizingMaskIntoConstraints = false
        shadowLayerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 31).isActive = true
        shadowLayerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
        shadowLayerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -31).isActive = true
        shadowLayerView.widthAnchor.constraint(equalToConstant: 162).isActive = true
        
        posterImageButton.translatesAutoresizingMaskIntoConstraints = false
        posterImageButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 21).isActive = true
        posterImageButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        posterImageButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -21).isActive = true
        posterImageButton.widthAnchor.constraint(equalToConstant: 182).isActive = true
    }
    func updateCell(movie : MovieDetailsType)
    {
        movieDetails = movie
        posterImageButton.setImage(nil, for: .normal)
        viewDelegate?.getPicture(url: movie.posterURL, completion: {(picture) in
            DispatchQueue.main.async {
                if picture.url == self.movieDetails.posterURL
                {
                    self.posterImageButton.setImage(picture.image, for: .normal)
                    self.posterImageButton.imageView?.contentMode = .scaleToFill
                }
            }
        })
    }
    @objc func openDetailsView()
    {
        viewDelegate!.openDetailsView(movie:movieDetails)
    }
}
