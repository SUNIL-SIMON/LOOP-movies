//
//  HomeView.swift
//  LOOP Movies
//
//  Created by SIMON on 16/11/22.
//

import Foundation
import UIKit
protocol HomeViewDelegate : NSObject
{
    func getMoviesList(rating : [RatingFilterType], searchText : String, type : SearchType)->[MovieDetailsType]
    func getStaffPickedMoviesList()->[MovieDetailsType]
    func getPicture(url : String, completion : @escaping(PicturesType)->Void)
    func openSearchView(type : SearchType)
    func openDetailsView(movie:MovieDetailsType)
    func closeSearchView()
    func setBookMark(selected : Bool, movieID : Int)
}
class HomeView : UIView, UITableViewDelegate, UITableViewDataSource, StaffPicksTableViewCellDelegate, CollectionViewCellDelegate
{
    
    

    let baseTableView = UITableView()
    let baseView = UIImageView()
    var baseViewConstraint = NSLayoutConstraint()
    weak var presenterDelegate : HomeViewDelegate?
    {
        didSet
        {
            setupViews()
        }
    }
    init()
    {
        print("Class HomeView init/deinit +")
        super.init(frame: .zero)
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        print("Class HomeView init/deinit -")
    }
    
    
    func setupViews()
    {
        self.backgroundColor = .white
        
        self.addSubview(baseView)
        baseView.image = Appearance.shared.images.backgroundImage
        baseView.contentMode = .scaleToFill
        
        self.addSubview(baseTableView)
        baseTableView.backgroundColor = .clear
        baseTableView.contentInsetAdjustmentBehavior = .never
        baseTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        baseTableView.dataSource = self
        baseTableView.delegate = self
        baseTableView.tableHeaderView = nil

        addLayoutConstraints()
    }
    func addLayoutConstraints()
    {
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseViewConstraint = baseView.topAnchor.constraint(equalTo: self.topAnchor, constant:60 + getTopSafeArea() + (370 * 0.4) - baseTableView.contentOffset.y)
        baseViewConstraint.isActive = true
        baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true

        baseTableView.translatesAutoresizingMaskIntoConstraints = false
        baseTableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        baseTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        baseTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        baseTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2
        {
            return presenterDelegate!.getStaffPickedMoviesList().count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 60 + getTopSafeArea()
        }
        else if indexPath.section == 1
        {
            return 370
        }
        return 141
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2
        {
            return 30
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2{
            let sectionHeader = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))

            let titleLabel = HomeSectionLabel.init(string1: "OUR", string2: " STAFF PICKS", color: Appearance.shared.color.highEmphasis_Light)
            titleLabel.frame = CGRect.init(x: 30, y: 5, width: sectionHeader.frame.width-10, height: sectionHeader.frame.height-10)
            sectionHeader.addSubview(titleLabel)
            
            return sectionHeader
        }
        else{
            return nil
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            var cell = tableView.dequeueReusableCell(withIdentifier: "SEARCH") as! SearchTableViewCell?
            if cell == nil
            {
                cell = SearchTableViewCell(style: .default, reuseIdentifier: "SEARCH")
            }
            cell?.viewDelegate = self
            return cell!
        }
        else if indexPath.section == 1{
            var cell = tableView.dequeueReusableCell(withIdentifier: "FAVORITES") as! FavoritesTableViewCell?
            if cell == nil
            {
                cell = FavoritesTableViewCell(style: .default, reuseIdentifier: "FAVORITES")
            }
            cell?.favoritesCollectionView.viewDelegate = self
            cell?.favoritesCollectionView.reloadData()
            return cell!
        }
        else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "STAFFPICKS") as! StaffPicksTableViewCell?
            if cell == nil
            {
                cell = StaffPicksTableViewCell(style: .default, reuseIdentifier: "STAFFPICKS")
            }
            let movies = presenterDelegate!.getStaffPickedMoviesList()
            cell?.viewDelegate = self
            cell?.updateCell(movie: movies[indexPath.row])
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 2
        {
            let movies = presenterDelegate!.getStaffPickedMoviesList()
            presenterDelegate?.openDetailsView(movie:movies[indexPath.row])
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        baseViewConstraint.constant = 60 + getTopSafeArea() + (370 * 0.4) - baseTableView.contentOffset.y
    }
    func getTopSafeArea()->CGFloat
    {
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top ?? 20
        return topPadding
    }
    /////////////////////////////////////////////////////////////////////////////////DELEGATE FUNCTIONS
    func getPicture(url : String, completion : @escaping(PicturesType)->Void)
    {
        presenterDelegate!.getPicture(url: url, completion: completion)
    }
    func getMoviesList(rating : [RatingFilterType], searchText : String, type : SearchType)->[MovieDetailsType] {
        return presenterDelegate?.getMoviesList(rating : rating, searchText : searchText, type: type) ?? []
    }
    func openSearchView() {
        presenterDelegate?.openSearchView(type: .ALLMOVIES)
    }
    func openSearchView(type: SearchType) {
        presenterDelegate?.openSearchView(type: type)
    }
    func openDetailsView(movie:MovieDetailsType)
    {
        presenterDelegate?.openDetailsView(movie:movie)
    }
    func closeSearchView()
    {
        presenterDelegate?.closeSearchView()
    }
    func setBookMark(selected : Bool, movieID : Int)
    {
        presenterDelegate?.setBookMark(selected: selected, movieID: movieID)
    }
}
