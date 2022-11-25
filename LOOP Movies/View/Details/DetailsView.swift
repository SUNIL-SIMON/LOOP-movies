//
//  DetailsView.swift
//  LOOP Movies
//
//  Created by SIMON on 17/11/22.
//

import Foundation
import UIKit
protocol DetailsViewDelegate : NSObject
{
    func closeDetailsView()
    func getPicture(url : String, completion : @escaping(PicturesType)->Void)
    func setBookMark(selected : Bool, movieID : Int)
}
class DetailsView : UIView, UIScrollViewDelegate, CrewCollectionViewCellDelegate
{
    
    
    let closeButton = UIButton()
    let topBarTitleLabel = UILabel()
    let bookMarkButton = BookMarkButton(outlineImage: Appearance.shared.images.bookMarkDark)
    let topBarView = BlurView()
    
    let baseView = TopRoundedView()
    var baseViewTopPostConstraint = NSLayoutConstraint()
    var baseViewTopPreConstraint = NSLayoutConstraint()
    
    let detailsScrollView = UIScrollView()
    
    let posterImage = UIImageView()
    let posterImageShadowLayerView = UIView()
    
    var genereLabelsArray : [UILabel] = []
    var genereView = UIView()
    var genereRowViewsArray : [UIView] = []
    var genereViewWidthConstraint = NSLayoutConstraint()
    var genereViewHeightConstraint = NSLayoutConstraint()
    
    let ratingsView = UIView()
    var ratingsViewArray : [UIImageView] = []
    
    var releaseAndRuntimeLabel = UILabel()
    
    var movieTitleLabel = UILabel()
    
    var OverViewSectionLabel = BodyTitleLabel(color: Appearance.shared.color.highEmphasis)
    var OverViewDescriptionLabel = UILabel()
    
    var directorSectionLabel = BodyTitleLabel(color: Appearance.shared.color.highEmphasis)
    let directorImageShadowLayerView = UIView()
    let directorImageView = UIImageView()
    let castLabel = UILabel()
    
    var actorsSectionLabel = BodyTitleLabel(color: Appearance.shared.color.highEmphasis)
    var actorCollectionView = CrewCollectionView()
    
    var KeyFactsSectionLabel = BodyTitleLabel(color: Appearance.shared.color.highEmphasis)
    var KeyFactsViews = UIView()
    var budgetBubbleView = KeyFactsBubbleView()
    var revenueBubbleView = KeyFactsBubbleView()
    var languageBubbleView = KeyFactsBubbleView()
    var ratingBubbleView = KeyFactsBubbleView()

    var movieDetails = MovieDetailsType(movieID: 0, title: "", posterURL: "", releaseDate: "", rating: 0, genres: [], director: DirectorType(name: "", pictureURL: ""),cast: [], overview: "",budget: 0,language: "",revenue: 0,reviews: 0, runningTime: 0, bookMarked: false)
    
    weak var presenterDelegate : DetailsViewDelegate?
    {
        didSet
        {
            setupViews()
        }
    }
    init()
    {
        print("Class DetailsView init/deinit +")
        super.init(frame: .zero)
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        print("Class DetailsView init/deinit -")
    }
    
    func setupViews()
    {
        
        
        self.addSubview(baseView)
        baseView.backgroundColor = .white

        topBarView.addSubview(closeButton)
        closeButton.setImage(Appearance.shared.images.closeImage, for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.addTarget(self, action: #selector(closeDetailsView), for: .touchUpInside)
        
        topBarView.addSubview(bookMarkButton)
        bookMarkButton.addTarget(self, action: #selector(bookMarkSelected), for: .touchUpInside)

        topBarView.addSubview(topBarTitleLabel)
        topBarTitleLabel.textColor = .black
        topBarTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        topBarTitleLabel.text = ""
        topBarTitleLabel.isHidden = true
        
        baseView.addSubview(detailsScrollView)
        detailsScrollView.delegate = self
        
        baseView.addSubview(topBarView)
        topBarView.backgroundColor = .clear
        
        detailsScrollView.addSubview(posterImageShadowLayerView)
        posterImageShadowLayerView.backgroundColor = .white
        posterImageShadowLayerView.dropShadow(opacity: 0.9, shadowRadius: 15)
        
        detailsScrollView.addSubview(posterImage)
        posterImage.backgroundColor = .white
        posterImage.contentMode = .scaleToFill
        posterImage.layer.cornerRadius = 10
        posterImage.layer.masksToBounds = true
        
        detailsScrollView.addSubview(ratingsView)
        for _ in 0..<5
        {
            let star = UIImageView()
            star.image = Appearance.shared.images.unHighlightedLowEmphasisStar
            ratingsViewArray.append(star)
            ratingsView.addSubview(star)
        }
        
        detailsScrollView.addSubview(releaseAndRuntimeLabel)
        releaseAndRuntimeLabel.textAlignment = .center
        releaseAndRuntimeLabel.textColor = .black.withAlphaComponent(0.6)
        releaseAndRuntimeLabel.font = UIFont.systemFont(ofSize: 14)
        
        detailsScrollView.addSubview(movieTitleLabel)
        movieTitleLabel.textAlignment = .center
        movieTitleLabel.textColor = .black
        movieTitleLabel.font = UIFont.systemFont(ofSize: 24)
        movieTitleLabel.numberOfLines = 0
        
        detailsScrollView.addSubview(OverViewSectionLabel)
        OverViewSectionLabel.text = "Overview"
        
        detailsScrollView.addSubview(OverViewDescriptionLabel)
        OverViewDescriptionLabel.numberOfLines = 0
        OverViewDescriptionLabel.textColor = Appearance.shared.color.mediumEmphasis
        
        detailsScrollView.addSubview(genereView)
        
        detailsScrollView.addSubview(directorSectionLabel)
        directorSectionLabel.text = "Director"
        
        detailsScrollView.addSubview(directorImageShadowLayerView)
        directorImageShadowLayerView.backgroundColor = .white
        directorImageShadowLayerView.dropShadow(opacity: 0.7, shadowRadius: 20)
        
        detailsScrollView.addSubview(directorImageView)
        directorImageView.contentMode = .scaleToFill
        directorImageView.layer.cornerRadius = 10
        directorImageView.layer.masksToBounds = true
        
        directorImageView.addSubview(castLabel)
        castLabel.numberOfLines = 0
        castLabel.textColor = .white
        castLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)

        detailsScrollView.addSubview(actorsSectionLabel)
        actorsSectionLabel.text = "Actors"
        
        detailsScrollView.addSubview(actorCollectionView)
        actorCollectionView.viewDelegate = self
        
        detailsScrollView.addSubview(KeyFactsSectionLabel)
        KeyFactsSectionLabel.text = "Key Facts"
        
        detailsScrollView.addSubview(KeyFactsViews)
        KeyFactsViews.addSubview(budgetBubbleView)
        KeyFactsViews.addSubview(revenueBubbleView)
        KeyFactsViews.addSubview(languageBubbleView)
        KeyFactsViews.addSubview(ratingBubbleView)
        
        addLayoutConstraints()
    }
    func addLayoutConstraints()
    {

        topBarView.translatesAutoresizingMaskIntoConstraints = false
        topBarView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: 0).isActive = true
        topBarView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 0).isActive = true
        topBarView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 0).isActive = true
        topBarView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -20).isActive = true
        closeButton.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 20).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        bookMarkButton.translatesAutoresizingMaskIntoConstraints = false
        bookMarkButton.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -20).isActive = true
        bookMarkButton.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 25).isActive = true
        bookMarkButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        bookMarkButton.widthAnchor.constraint(equalToConstant: 14).isActive = true
        
        topBarTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        topBarTitleLabel.trailingAnchor.constraint(equalTo: bookMarkButton.leadingAnchor, constant: -20).isActive = true
        topBarTitleLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 25).isActive = true
        topBarTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        topBarTitleLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 30).isActive = true
        
        detailsScrollView.translatesAutoresizingMaskIntoConstraints = false
        detailsScrollView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 0).isActive = true
        detailsScrollView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: 0).isActive = true
        detailsScrollView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 0).isActive = true
        detailsScrollView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: 0).isActive = true

        posterImageShadowLayerView.translatesAutoresizingMaskIntoConstraints = false
        posterImageShadowLayerView.centerXAnchor.constraint(equalTo: baseView.centerXAnchor, constant: 0).isActive = true
        posterImageShadowLayerView.topAnchor.constraint(equalTo: detailsScrollView.topAnchor, constant: 110).isActive = true
        posterImageShadowLayerView.widthAnchor.constraint(equalToConstant: 183).isActive = true
        posterImageShadowLayerView.heightAnchor.constraint(equalToConstant: 275).isActive = true
        
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.centerXAnchor.constraint(equalTo: baseView.centerXAnchor, constant: 0).isActive = true
        posterImage.topAnchor.constraint(equalTo: detailsScrollView.topAnchor, constant: 100).isActive = true
        posterImage.heightAnchor.constraint(equalToConstant: 295).isActive = true
        posterImage.widthAnchor.constraint(equalToConstant: 203).isActive = true
        
        ratingsView.translatesAutoresizingMaskIntoConstraints = false
        ratingsView.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 18).isActive = true
        ratingsView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        ratingsView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        ratingsView.widthAnchor.constraint(equalToConstant: 88).isActive = true
        
        for i in 0..<ratingsViewArray.count
        {
            let star = ratingsViewArray[i]
            star.translatesAutoresizingMaskIntoConstraints = false
            star.topAnchor.constraint(equalTo: ratingsView.topAnchor, constant: 0).isActive = true
            star.leadingAnchor.constraint(equalTo: i == 0 ? ratingsView.leadingAnchor : ratingsViewArray[i - 1].trailingAnchor, constant: i == 0 ? 0 : 2).isActive = true
            star.heightAnchor.constraint(equalToConstant: 16).isActive = true
            star.widthAnchor.constraint(equalToConstant: 16).isActive = true
        }
        
        releaseAndRuntimeLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseAndRuntimeLabel.topAnchor.constraint(equalTo: ratingsView.bottomAnchor, constant: 12).isActive = true
        releaseAndRuntimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        releaseAndRuntimeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        releaseAndRuntimeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.topAnchor.constraint(equalTo: releaseAndRuntimeLabel.bottomAnchor, constant: 10).isActive = true
        movieTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        movieTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        
        genereView.translatesAutoresizingMaskIntoConstraints = false
        genereView.centerXAnchor.constraint(equalTo: baseView.centerXAnchor, constant: 0).isActive = true
        genereView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 10).isActive = true
        genereViewHeightConstraint = genereView.heightAnchor.constraint(equalToConstant: 30)
        genereViewHeightConstraint.isActive = true
        genereViewWidthConstraint = genereView.widthAnchor.constraint(equalToConstant: 100)
        genereViewWidthConstraint.isActive = true
        
        OverViewSectionLabel.translatesAutoresizingMaskIntoConstraints = false
        OverViewSectionLabel.topAnchor.constraint(equalTo: genereView.bottomAnchor, constant: 47).isActive = true
        OverViewSectionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        OverViewSectionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        OverViewSectionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        OverViewDescriptionLabel.sizeToFit()
        OverViewDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        OverViewDescriptionLabel.topAnchor.constraint(equalTo: OverViewSectionLabel.bottomAnchor, constant: 16).isActive = true
        OverViewDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        OverViewDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true

        directorSectionLabel.translatesAutoresizingMaskIntoConstraints = false
        directorSectionLabel.topAnchor.constraint(equalTo: OverViewDescriptionLabel.bottomAnchor, constant: 30).isActive = true
        directorSectionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        directorSectionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        directorSectionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        directorImageShadowLayerView.translatesAutoresizingMaskIntoConstraints = false
        directorImageShadowLayerView.topAnchor.constraint(equalTo: directorSectionLabel.bottomAnchor, constant: 26).isActive = true
        directorImageShadowLayerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
        directorImageShadowLayerView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        directorImageShadowLayerView.heightAnchor.constraint(equalToConstant: 130).isActive = true

        
        directorImageView.translatesAutoresizingMaskIntoConstraints = false
        directorImageView.topAnchor.constraint(equalTo: directorSectionLabel.bottomAnchor, constant: 16).isActive = true
        directorImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        directorImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        directorImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        castLabel.translatesAutoresizingMaskIntoConstraints = false
        castLabel.trailingAnchor.constraint(equalTo: directorImageView.trailingAnchor, constant: -8).isActive = true
        castLabel.leadingAnchor.constraint(equalTo: directorImageView.leadingAnchor, constant: 8).isActive = true
        castLabel.bottomAnchor.constraint(equalTo: directorImageView.bottomAnchor, constant: -8).isActive = true
        
        actorsSectionLabel.translatesAutoresizingMaskIntoConstraints = false
        actorsSectionLabel.topAnchor.constraint(equalTo: directorImageView.bottomAnchor, constant: 30).isActive = true
        actorsSectionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        actorsSectionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        actorsSectionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        actorCollectionView.translatesAutoresizingMaskIntoConstraints = false
        actorCollectionView.topAnchor.constraint(equalTo: actorsSectionLabel.bottomAnchor, constant: 16).isActive = true
        actorCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        actorCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        actorCollectionView.heightAnchor.constraint(equalToConstant: 190).isActive = true
        
        KeyFactsSectionLabel.translatesAutoresizingMaskIntoConstraints = false
        KeyFactsSectionLabel.topAnchor.constraint(equalTo: actorCollectionView.bottomAnchor, constant: 30).isActive = true
        KeyFactsSectionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        KeyFactsSectionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        KeyFactsSectionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        KeyFactsViews.translatesAutoresizingMaskIntoConstraints = false
        KeyFactsViews.topAnchor.constraint(equalTo: KeyFactsSectionLabel.bottomAnchor, constant: 15).isActive = true
        KeyFactsViews.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        KeyFactsViews.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        KeyFactsViews.heightAnchor.constraint(equalToConstant: 152).isActive = true
        
        budgetBubbleView.translatesAutoresizingMaskIntoConstraints = false
        budgetBubbleView.topAnchor.constraint(equalTo: KeyFactsViews.topAnchor, constant: 0).isActive = true
        budgetBubbleView.leadingAnchor.constraint(equalTo: KeyFactsViews.leadingAnchor, constant: 0).isActive = true
        budgetBubbleView.widthAnchor.constraint(equalTo: KeyFactsViews.widthAnchor, multiplier: 0.48).isActive = true
        budgetBubbleView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        revenueBubbleView.translatesAutoresizingMaskIntoConstraints = false
        revenueBubbleView.topAnchor.constraint(equalTo: KeyFactsViews.topAnchor, constant: 0).isActive = true
        revenueBubbleView.trailingAnchor.constraint(equalTo: KeyFactsViews.trailingAnchor, constant: 0).isActive = true
        revenueBubbleView.widthAnchor.constraint(equalTo: KeyFactsViews.widthAnchor, multiplier: 0.48).isActive = true
        revenueBubbleView.heightAnchor.constraint(equalToConstant: 70).isActive = true

        languageBubbleView.translatesAutoresizingMaskIntoConstraints = false
        languageBubbleView.topAnchor.constraint(equalTo: revenueBubbleView.bottomAnchor, constant: 12).isActive = true
        languageBubbleView.leadingAnchor.constraint(equalTo: KeyFactsViews.leadingAnchor, constant: 0).isActive = true
        languageBubbleView.widthAnchor.constraint(equalTo: KeyFactsViews.widthAnchor, multiplier: 0.48).isActive = true
        languageBubbleView.heightAnchor.constraint(equalToConstant: 70).isActive = true

        ratingBubbleView.translatesAutoresizingMaskIntoConstraints = false
        ratingBubbleView.topAnchor.constraint(equalTo: revenueBubbleView.bottomAnchor, constant: 12).isActive = true
        ratingBubbleView.trailingAnchor.constraint(equalTo: KeyFactsViews.trailingAnchor, constant: 0).isActive = true
        ratingBubbleView.widthAnchor.constraint(equalTo: KeyFactsViews.widthAnchor, multiplier: 0.48).isActive = true
        ratingBubbleView.heightAnchor.constraint(equalToConstant: 70).isActive = true

    }
    override func layoutSubviews() {

        let contentheight =  KeyFactsViews.frame.origin.y + KeyFactsViews.frame.size.height

        detailsScrollView.contentSize.height = contentheight + 30
    }
    @objc func closeDetailsView()
    {
        presenterDelegate!.closeDetailsView()
    }
    func updateDetails(movie : MovieDetailsType)
    {
        movieDetails = movie
        releaseAndRuntimeLabel.text = movie.releaseDate.getDateAndRunTime(runningHours: movie.runningTime)
        movieTitleLabel.attributedText = getAttributedTitle(string1: movie.title, string2: " (\(movie.releaseDate.getYear()))", color: Appearance.shared.color.backgroundColor)
        castLabel.text = movie.director.name
        OverViewDescriptionLabel.text = movie.overview
        topBarTitleLabel.text =  movie.title
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        let budgetString = currencyFormatter.string(from: NSNumber(value: Int(movie.budget)))!
        let revenueString = currencyFormatter.string(from: NSNumber(value: Int(movie.revenue)))!
        budgetBubbleView.set(title: "Budget", value: "\(budgetString.replacingOccurrences(of: ".00", with: "").replacingOccurrences(of: ",", with: "."))")
        revenueBubbleView.set(title: "Revenue", value: "\(revenueString.replacingOccurrences(of: ".00", with: "").replacingOccurrences(of: ",", with: "."))")
        
        var lang = movie.language
        let langCode = Bundle.main.preferredLocalizations[0]
        let usLocale = Locale(identifier: movie.language)
        if let languageName = usLocale.localizedString(forLanguageCode: langCode) {
            lang = languageName
        }
        languageBubbleView.set(title: "Original Language", value: "\(lang)")
        ratingBubbleView.set(title: "Rating", value: "\(movie.rating.rounded(toPlaces: 2)) (\(movie.reviews))")
        
        bookMarkButton.set(selected: movie.bookMarked)
        for i in 0..<ratingsViewArray.count
        {
            ratingsViewArray[i].image = Appearance.shared.images.unHighlightedLowEmphasisStar
        }
        for i in 0..<Int(movie.rating.rounded())
        {
            ratingsViewArray[i].image = Appearance.shared.images.highlightedStar
        }
        addGenres(movie: movie)
        self.posterImage.image = nil
        presenterDelegate?.getPicture(url: movie.posterURL, completion: {(picture) in
            DispatchQueue.main.async {
                if picture.url == self.movieDetails.posterURL
                {
                    self.posterImage.image = picture.image!
                }
            }
        })
        self.directorImageView.image = nil
        presenterDelegate?.getPicture(url: movie.director.pictureURL, completion: {(picture) in
            DispatchQueue.main.async {
                if picture.url == self.movieDetails.director.pictureURL
                {
                    self.directorImageView.image = picture.image!
                }
            }
        })
        actorCollectionView.reloadData()
        
        layoutSubviews()
    }
    func addGenres(movie : MovieDetailsType)
    {
        for j in 0..<genereRowViewsArray.count
        {
            for i in 0..<genereLabelsArray.count
            {
                genereLabelsArray[i].removeFromSuperview()
            }
            genereLabelsArray.removeAll()
            genereRowViewsArray[j].removeFromSuperview()
        }
        genereRowViewsArray.removeAll()
        var maxWidth : CGFloat = 0
        var totalHeight : CGFloat = 0
        let count = Int((CGFloat(movie.genres.count)/3).rounded(.up))
        for j in 0..<count
        {
            let rowView = UIView()
            genereRowViewsArray.append(rowView)
            genereView.addSubview(rowView)
            rowView.translatesAutoresizingMaskIntoConstraints = false
            rowView.centerXAnchor.constraint(equalTo: genereView.centerXAnchor, constant: 0).isActive = true
            rowView.topAnchor.constraint(equalTo: j == 0 ? genereView.topAnchor : genereRowViewsArray[j-1].bottomAnchor, constant: 5).isActive = true
            rowView.heightAnchor.constraint(equalToConstant: 30).isActive = true
            var totalWidth : CGFloat = 0
            let count2 = (j == count - 1) ?  movie.genres.count: ((3*j) + 3)
            var lastLabel : UILabel?
            for i in (3 * j)..<count2
            {
                
                let lbl = UILabel()
                lbl.text = "   \(movie.genres[i])   "
                lbl.font = UIFont.systemFont(ofSize: 12)
                lbl.textColor = .black
                genereLabelsArray.append(lbl)
                rowView.addSubview(lbl)
                lbl.sizeToFit()
                lbl.translatesAutoresizingMaskIntoConstraints = false
                lbl.leadingAnchor.constraint(equalTo: (i - (3 * j)) == 0 ? rowView.leadingAnchor : lastLabel!.trailingAnchor, constant: 10).isActive = true
                lbl.topAnchor.constraint(equalTo: rowView.topAnchor, constant: 0).isActive = true
                lbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
                lbl.layer.cornerRadius = 15
                lbl.layer.masksToBounds = true
                lbl.backgroundColor = Appearance.shared.color.veryLowEmphasis
                lastLabel = lbl
                totalWidth = totalWidth + 10 + lbl.frame.size.width
            }
            rowView.widthAnchor.constraint(equalToConstant: totalWidth).isActive = true
            maxWidth = maxWidth > totalWidth ? maxWidth : totalWidth
            totalHeight = totalHeight + 35
        }
        genereViewWidthConstraint.constant = maxWidth
        genereViewHeightConstraint.constant = totalHeight
        
    }
    func getAttributedTitle(string1 : String, string2 : String, color : UIColor)->NSMutableAttributedString
    {

        let myAttribute1 = [ NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)]
        let myAttrString1 = NSMutableAttributedString(string: string1, attributes: myAttribute1)
        
        let myAttribute2 = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)]
        let myAttrString2 = NSMutableAttributedString(string: string2, attributes: myAttribute2)
        
        let combination = NSMutableAttributedString()
        combination.append(myAttrString1)
        combination.append(myAttrString2)
        return combination
    }
    func getPicture(url: String, completion: @escaping (PicturesType) -> Void) {
        presenterDelegate?.getPicture(url: url, completion: completion)
    }
    
    func getCastList() -> [CastType] {
        return movieDetails.cast
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > (movieTitleLabel.frame.size.height + movieTitleLabel.frame.origin.y - topBarView.frame.size.height)
        {
            topBarTitleLabel.isHidden = false
        }
        else{
            topBarTitleLabel.isHidden = true
        }
    }
    @objc func bookMarkSelected()
    {
        presenterDelegate?.setBookMark(selected : !movieDetails.bookMarked, movieID: movieDetails.movieID)
    }
}
