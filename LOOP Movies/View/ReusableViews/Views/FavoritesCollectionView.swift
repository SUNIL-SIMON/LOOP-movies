//
//  FavoritesCollectionView.swift
//  LOOP Movies
//
//  Created by SIMON on 16/11/22.
//

import Foundation
import UIKit
class FavoritesCollectionView : UICollectionView,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate
{

    weak var viewDelegate : CollectionViewCellDelegate?
    {
        didSet
        {
            setupViews()
        }
    }
    init()
    {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: collectionViewLayout)
        print("Class FavoritesCollectionView init/deinit +")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        print("Class FavoritesCollectionView init/deinit -")
    }
    
    func setupViews()
    {
        backgroundColor = .clear
        
        self.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: "DEFAULT")
        self.register(SeeAllCollectionViewCell.self, forCellWithReuseIdentifier: "SEEALL")
        self.alwaysBounceHorizontal = true
        self.showsHorizontalScrollIndicator = false
        self.delegate = self
        self.dataSource = self
    }    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewDelegate!.getMoviesList(rating : [._All], searchText : "", type: .FAVORITES).count > 3 ? 4 : viewDelegate!.getMoviesList(rating : [._All], searchText : "", type: .FAVORITES).count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 212, height:  312)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section < 3{
            let cell = self.dequeueReusableCell(withReuseIdentifier: "DEFAULT", for: indexPath) as! FavoritesCollectionViewCell
            cell.viewDelegate = viewDelegate
            let movies = viewDelegate!.getMoviesList(rating : [._All], searchText : "", type: .FAVORITES)
            cell.updateCell(movie : movies[indexPath.section])
            return cell
        }
        else{
            let cell = self.dequeueReusableCell(withReuseIdentifier: "SEEALL", for: indexPath) as! SeeAllCollectionViewCell
            cell.viewDelegate = viewDelegate
            return cell
        }
    }
}
