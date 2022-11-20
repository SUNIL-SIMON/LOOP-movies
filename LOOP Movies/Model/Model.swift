//
//  Model.swift
//  LOOP Movies
//
//  Created by SIMON on 16/11/22.
//

import Foundation
import UIKit
protocol ModelDelegate : NSObject
{
    func reloadView()
}
class Model{
    
    
    let requestHandler = RequestHandler()
    
    var staffPickedMoviesList : [MovieDetailsType] = []
    var allMoviesList : [MovieDetailsType] = []
    var picturesDictionary : [String : PicturesType] = [:]
    
    weak var presenterDelegate : ModelDelegate?
    
    init()
    {
        getStaffPickedMoviesList()
        getAllMoviesList()
    }
    func reloadView()
    {
        presenterDelegate?.reloadView()
    }
    func getStaffPickedMoviesList()
    {
        staffPickedMoviesList.removeAll()
        requestHandler.makeServerCall(urlString: URLApiConstants.staffPicksApi, completion: {(data,success) in
            if success{
                DispatchQueue.main.async {
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                        
                        guard let array = json as? NSMutableArray else{ return }
                        for details in array
                        {
                            guard let movieDetails = details as? [String : Any] else{ return }
                            let entry = self.getprocessedData(movieDetails: movieDetails)
                            self.staffPickedMoviesList.append(entry)
                        }
                        self.reloadView()
                    }catch{}
                }
            }
        })
    }
    func getAllMoviesList()
    {
        allMoviesList.removeAll()
        requestHandler.makeServerCall(urlString: URLApiConstants.moviesApi, completion: {(data,success) in
            if success{
                DispatchQueue.main.async {
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                        
                        guard let array = json as? NSMutableArray else{ return }
                        for details in array
                        {
                            guard let movieDetails = details as? [String : Any] else{ return }
                            let entry = self.getprocessedData(movieDetails: movieDetails)
                            self.allMoviesList.append(entry)
                        }
                        self.reloadView()
                    }catch{}
                }
            }
        })
    }
    func getprocessedData(movieDetails:[String : Any])->MovieDetailsType
    {

        var posterUrl = ""
        if let posterUrlResp = movieDetails["posterUrl"] as? String
        {
            posterUrl = posterUrlResp
        }
        var id = 0
        if let idResp = movieDetails["id"] as? Int
        {
            id = idResp
        }
        var releaseDate = ""
        if let releaseDateResp = movieDetails["releaseDate"] as? String
        {
            releaseDate = releaseDateResp
        }
        var title = ""
        if let titleResp = movieDetails["title"] as? String
        {
            title = titleResp
        }
        var rating : CGFloat = 0
        if let ratingResp = movieDetails["rating"] as? CGFloat
        {
            rating = ratingResp
        }
        var genres : [String] = []
        if let genresResp = movieDetails["genres"] as? NSMutableArray
        {
            for genre in genresResp
            {
                if let genreResp = genre as? String
                {
                    genres.append(genreResp)
                }
            }
        }
        var director = DirectorType(name: "", pictureURL: "")
        if let diectorResp = movieDetails["director"] as? [String : Any]
        {
            var name = ""
            if let nameResp = diectorResp["name"] as? String
            {
                name = nameResp
            }
            var pictureUrl = ""
            if let pictureUrlResp = diectorResp["pictureUrl"] as? String
            {
                pictureUrl = pictureUrlResp
            }
            director = DirectorType(name: name, pictureURL: pictureUrl)
        }
        var cast : [CastType] = []
        if let castResp = movieDetails["cast"] as? NSMutableArray
        {
            for person in castResp
            {
                if let personResp = person as? [String : Any]
                {
                    var name = ""
                    if let nameResp = personResp["name"] as? String
                    {
                        name = nameResp
                    }
                    var pictureUrl = ""
                    if let pictureUrlResp = personResp["pictureUrl"] as? String
                    {
                        pictureUrl = pictureUrlResp
                    }
                    var character = ""
                    if let characterResp = personResp["character"] as? String
                    {
                        character = characterResp
                    }
                    cast.append(CastType(name: name, pictureURL: pictureUrl, character: character))
                }
            }
        }
        var overview = ""
        if let overviewResp = movieDetails["overview"] as? String
        {
            overview = overviewResp
        }
        var budget : Double = 0
        if let budgetResp = movieDetails["budget"] as? Double
        {
            budget = budgetResp
        }
        var language = ""
        if let languageResp = movieDetails["language"] as? String
        {
            language = languageResp
        }
        var revenue : Double = 0
        if let revenueResp = movieDetails["revenue"] as? Double
        {
            revenue = revenueResp
        }
        var reviews : Int = 0
        if let reviewsResp = movieDetails["reviews"] as? Int
        {
            reviews = reviewsResp
        }
        var runningTime = 0
        if let runningTimeResp = movieDetails["runtime"] as? Int
        {
            runningTime = runningTimeResp
        }
        
        let entry = MovieDetailsType(movieID: id,title : title, posterURL: posterUrl, releaseDate : releaseDate, rating: rating, genres: genres, director: director,cast: cast,overview: overview,budget: budget,language: language,revenue: revenue,reviews: reviews, runningTime: runningTime, bookMarked: false)
        return entry
    }
    func getPicture(url : String, completion : @escaping(PicturesType)->Void)
    {
        DispatchQueue.main.async {
            if self.picturesDictionary[url] != nil
            {
                completion(self.picturesDictionary[url]!)
            }
            else{
                self.requestHandler.makeServerCall(urlString: url, completion: {(data,success) in
                    if success{
                       if let img = UIImage(data: data)
                       {
                           self.picturesDictionary[url] = PicturesType(url: url, image: img)
                           completion(self.picturesDictionary[url]!)
                       }
                    }
                })
            }
        }
    }
    func getMoviesList(rating : [RatingFilterType], searchText : String, type : SearchType)->[MovieDetailsType]
    {
        if searchText == "" && (rating.contains(._All) || rating == []){
            if type == .FAVORITES{
                let filteredlist = allMoviesList.filter{Int($0.rating.rounded()) >= 4}
                return filteredlist
            }
            else{
                return allMoviesList
            }
        }
        else{
            var filteredlist : [MovieDetailsType] = []
            var list = allMoviesList
            if type == .FAVORITES
            {
                list = allMoviesList.filter{Int($0.rating.rounded()) >= 4}
            }
            if rating.contains(._1Star)
            {
                filteredlist.append(contentsOf: list.filter{Int($0.rating.rounded()) == 1})
            }
            if rating.contains(._2Star)
            {
                filteredlist.append(contentsOf: list.filter{Int($0.rating.rounded()) == 2})
            }
            if rating.contains(._3Star)
            {
                filteredlist.append(contentsOf: list.filter{Int($0.rating.rounded()) == 3})
            }
            if rating.contains(._4Star)
            {
                filteredlist.append(contentsOf: list.filter{Int($0.rating.rounded()) == 4})
            }
            if rating.contains(._5Star)
            {
                filteredlist.append(contentsOf: list.filter{Int($0.rating.rounded()) == 5})
            }
            
            if (rating.contains(._All) || rating == [])
            {
                if type == .FAVORITES{
                    filteredlist = allMoviesList.filter{Int($0.rating.rounded()) >= 4}
                }
                else{
                    filteredlist = allMoviesList
                }
            }
            if searchText != ""{
                filteredlist =  filteredlist.filter{$0.title.lowercased().contains(searchText.lowercased())}
            }
            return filteredlist
        }
    }
    func setBookMark(selected : Bool, movieID : Int){
        var idx = allMoviesList.firstIndex{$0.movieID == movieID}
        if idx != nil{
            allMoviesList[idx!].bookMarked = selected
        }
        idx = staffPickedMoviesList.firstIndex{$0.movieID == movieID}
        if idx != nil{
            staffPickedMoviesList[idx!].bookMarked = selected
        }
        reloadView()
    }
}
