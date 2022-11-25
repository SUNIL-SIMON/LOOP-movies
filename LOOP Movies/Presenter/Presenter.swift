//
//  Presenter.swift
//  LOOP Movies
//
//  Created by SIMON on 16/11/22.
//

import Foundation
import UIKit
class Presenter : UIViewController, ModelDelegate, HomeViewDelegate, DetailsViewDelegate, SearchViewDelegate{

    let dataModel = Model()
    let homeView = HomeView()
    let searchView = SearchView()
    let detailsView = DetailsView()
    init()
    {
        super.init(nibName: nil, bundle: nil)
        print("Class Presenter init/deinit +")
        self.view = homeView
        dataModel.presenterDelegate = self
        homeView.presenterDelegate = self
        detailsView.presenterDelegate = self
        searchView.presenterDelegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        print("Class Presenter init/deinit -")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    /////////////////////////////////////////////////////////////////////////////////DELEGATE FUNCTIONS
    func reloadView()
    {
        homeView.baseTableView.reloadData()
        searchView.reloadData()
        let idx = dataModel.allMoviesList.firstIndex{$0.movieID == detailsView.movieDetails.movieID}
        if idx != nil{
            detailsView.updateDetails(movie: dataModel.allMoviesList[idx!])
        }
    }
    func setBookMark(selected : Bool, movieID : Int)
    {
        dataModel.setBookMark(selected: selected, movieID: movieID)
    }
    func getStaffPickedMoviesList()->[MovieDetailsType]
    {
        return dataModel.staffPickedMoviesList
    }
    func getMoviesList(rating : [RatingFilterType], searchText : String, type : SearchType)->[MovieDetailsType]
    {
        return dataModel.getMoviesList(rating: rating, searchText: searchText, type: type)
    }
    func getPicture(url : String, completion : @escaping(PicturesType)->Void)
    {
        dataModel.getPicture(url: url, completion: completion)
    }
    func openSearchView(type : SearchType)
    {
        let searchViewController = UIViewController()
        searchView.searchType = type
        searchViewController.view = searchView
        searchView.reloadData()
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
    func openDetailsView(movie:MovieDetailsType)
    {
        detailsView.updateDetails(movie: movie)
        let searchViewController = UIViewController()
        searchViewController.view = detailsView
        searchViewController.modalPresentationStyle = .overCurrentContext
        self.detailsView.isHidden = true
        self.navigationController?.present(searchViewController, animated: false, completion: {
            self.detailsView.backgroundColor = .clear
            self.detailsView.baseView.frame = CGRect(x: 0, y: self.detailsView.frame.size.height, width: self.detailsView.frame.size.width, height: self.detailsView.frame.size.height)
            self.detailsView.isHidden = false
            UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
                self.detailsView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                self.detailsView.baseView.frame = CGRect(x: 0, y: 70, width: self.detailsView.frame.size.width, height: self.detailsView.frame.size.height - 70)
            }, completion: {_ in

            })
        })

    }
    func closeDetailsView()
    {
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.detailsView.backgroundColor = .clear
            self.detailsView.baseView.frame = CGRect(x: 0, y: self.detailsView.frame.size.height, width: self.detailsView.frame.size.width, height: self.detailsView.frame.size.height)
        }, completion: {_ in
            self.navigationController?.dismiss(animated: false, completion: {})
        })
    }
    func closeSearchView()
    {
        self.navigationController?.popViewController(animated: true)
    }
}
