//
//  StaffPicksTableViewCell.swift
//  LOOP Movies
//
//  Created by SIMON on 16/11/22.
//

import Foundation
import UIKit
protocol StaffPicksTableViewCellDelegate : NSObject
{
    func getPicture(url : String, completion : @escaping(PicturesType)->Void)
    func setBookMark(selected : Bool, movieID : Int)
}
class StaffPicksTableViewCell : UITableViewCell
{
    let releaseDateLabel = CaptionLabel(color: Appearance.shared.color.mediumEmphasis_Light)
    let movieTitleLabel = BodyTitleLabel(color: Appearance.shared.color.highEmphasis_Light)
    let ratingsView = UIView()
    var ratingsViewArray : [UIImageView] = []
    let posterImageView = UIImageView()
    let bookMarkButton = BookMarkButton(outlineImage: Appearance.shared.images.bookMarkBaseImage)
    let seperator = UIView()
    var movieDetails = MovieDetailsType(movieID: 0, title: "", posterURL: "", releaseDate: "", rating: 0, genres: [], director: DirectorType(name: "", pictureURL: ""),cast: [],overview: "",budget: 0,language: "",revenue: 0,reviews: 0, runningTime: 0, bookMarked: false)
    weak var viewDelegate : StaffPicksTableViewCellDelegate?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("Class StaffPicksTableViewCell init/deinit +")
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        print("Class StaffPicksTableViewCell init/deinit -")
    }
    
    func setupViews()
    {
        backgroundColor = .clear
        
        self.contentView.addSubview(posterImageView)
        posterImageView.backgroundColor = .white
        posterImageView.layer.cornerRadius = 10
        posterImageView.contentMode = .scaleToFill
        posterImageView.layer.masksToBounds = true
        
        
        self.contentView.addSubview(releaseDateLabel)
        releaseDateLabel.text = ""
        
        self.contentView.addSubview(movieTitleLabel)
        movieTitleLabel.text = ""
        
        self.contentView.addSubview(ratingsView)
        for _ in 0..<5
        {
            let star = UIImageView()
            star.image = Appearance.shared.images.unHighlightedStar
            ratingsViewArray.append(star)
            self.ratingsView.addSubview(star)
        }
        
        self.contentView.addSubview(bookMarkButton)
        bookMarkButton.addTarget(self, action: #selector(bookMarkSelected), for: .touchUpInside)
        
        self.contentView.addSubview(seperator)
        seperator.backgroundColor = Appearance.shared.color.lowEmphasis_Light
        
        addLayoutConstraints()
    }
    func addLayoutConstraints()
    {
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 26).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 89).isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 44).isActive = true
        releaseDateLabel.leadingAnchor.constraint(equalTo: self.posterImageView.trailingAnchor, constant: 26).isActive = true
        releaseDateLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        releaseDateLabel.trailingAnchor.constraint(equalTo: bookMarkButton.leadingAnchor, constant: -10).isActive = true
        
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 3).isActive = true
        movieTitleLabel.leadingAnchor.constraint(equalTo: self.posterImageView.trailingAnchor, constant: 26).isActive = true
        movieTitleLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
        movieTitleLabel.trailingAnchor.constraint(equalTo: bookMarkButton.leadingAnchor, constant: -10).isActive = true
        
        ratingsView.translatesAutoresizingMaskIntoConstraints = false
        ratingsView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 3).isActive = true
        ratingsView.leadingAnchor.constraint(equalTo: self.posterImageView.trailingAnchor, constant: 26).isActive = true
        ratingsView.heightAnchor.constraint(equalToConstant: 9).isActive = true
        ratingsView.trailingAnchor.constraint(equalTo: bookMarkButton.leadingAnchor, constant: -10).isActive = true
        
        for i in 0..<ratingsViewArray.count
        {
            let star = ratingsViewArray[i]
            star.translatesAutoresizingMaskIntoConstraints = false
            star.topAnchor.constraint(equalTo: ratingsView.topAnchor, constant: 0).isActive = true
            star.leadingAnchor.constraint(equalTo: i == 0 ? ratingsView.leadingAnchor : ratingsViewArray[i - 1].trailingAnchor, constant: i == 0 ? 0 : 2).isActive = true
            star.heightAnchor.constraint(equalToConstant: 9).isActive = true
            star.widthAnchor.constraint(equalToConstant: 9).isActive = true
        }
        
        bookMarkButton.translatesAutoresizingMaskIntoConstraints = false
        bookMarkButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 62).isActive = true
        bookMarkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        bookMarkButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        bookMarkButton.widthAnchor.constraint(equalToConstant: 14).isActive = true
        
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 116).isActive = true
        
    }
    
    func updateCell(movie : MovieDetailsType)
    {
        movieDetails = movie
        movieTitleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate.getYear()
        bookMarkButton.set(selected:movie.bookMarked)
        posterImageView.image = nil
        posterImageView.shimmer(size: 300)
        for i in 0..<ratingsViewArray.count
        {
            ratingsViewArray[i].image = Appearance.shared.images.unHighlightedStar
        }
        for i in 0..<Int(movie.rating.rounded())
        {
            ratingsViewArray[i].image = Appearance.shared.images.highlightedStar
        }
        viewDelegate?.getPicture(url: movie.posterURL, completion: {(picture) in
            DispatchQueue.main.async {
                if picture.url == self.movieDetails.posterURL
                {
                    self.posterImageView.layer.mask = nil
                    self.posterImageView.image = picture.image!
                }
            }
        })
    }
    @objc func bookMarkSelected()
    {
        viewDelegate?.setBookMark(selected : !movieDetails.bookMarked, movieID: movieDetails.movieID)
    }
}
