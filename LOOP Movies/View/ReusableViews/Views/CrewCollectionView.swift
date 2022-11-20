//
//  CrewCollectionView.swift
//  LOOP Movies
//
//  Created by SIMON on 17/11/22.
//

import Foundation
import UIKit
class CrewCollectionView : UICollectionView,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate
{

    weak var viewDelegate : CrewCollectionViewCellDelegate?
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
        print("Class CrewCollectionView init/deinit +")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        print("Class CrewCollectionView init/deinit -")
    }
    
    func setupViews()
    {
        backgroundColor = .clear
        
        self.register(CrewCollectionViewCell.self, forCellWithReuseIdentifier: "DEFAULT")
        self.alwaysBounceHorizontal = true
        self.showsHorizontalScrollIndicator = false
        self.delegate = self
        self.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewDelegate!.getCastList().count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height:  190)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = self.dequeueReusableCell(withReuseIdentifier: "DEFAULT", for: indexPath) as! CrewCollectionViewCell
        cell.viewDelegate = viewDelegate
        let cast = viewDelegate!.getCastList()
        cell.updateCell(cast: cast[indexPath.section])
        return cell
      
    }
}
