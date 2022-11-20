//
//  SearchView.swift
//  LOOP Movies
//
//  Created by SIMON on 17/11/22.
//

import Foundation
import UIKit
protocol SearchViewDelegate : NSObject
{
    func getMoviesList(rating : [RatingFilterType], searchText : String, type : SearchType)->[MovieDetailsType]
    func getPicture(url : String, completion : @escaping(PicturesType)->Void)
    func openDetailsView(movie:MovieDetailsType)
    func closeSearchView()
    func setBookMark(selected : Bool, movieID : Int)
}
class SearchView : UIView, UITableViewDelegate, UITableViewDataSource, StaffPicksTableViewCellDelegate, UITextFieldDelegate
{

    var searchTextField = UITextField()
    var searchTextFieldBaseView = UIView()
    var backNavigationButton = UIButton()
    var ratingsFilterScrollView = UIScrollView()
    let searchTableView = UITableView()
    let rated1StarButton = RatingsFilterButton.init(ratingCount: 1)
    let rated2StarButton = RatingsFilterButton.init(ratingCount: 2)
    let rated3StarButton = RatingsFilterButton.init(ratingCount: 3)
    let rated4StarButton = RatingsFilterButton.init(ratingCount: 4)
    let rated5StarButton = RatingsFilterButton.init(ratingCount: 5)
    let emptyStateImageView = EmptyStateView()
    var filteredList : [MovieDetailsType] = []
    var ratingFilters : [RatingFilterType] = []
    var searchType = SearchType.ALLMOVIES
    {
        didSet
        {
            searchTextField.attributedPlaceholder = NSAttributedString(
                string: ((searchType == .ALLMOVIES) ? "Search all movies" : "Search all favorites"),
                attributes: [NSAttributedString.Key.foregroundColor: Appearance.shared.color.lowEmphasis_Light]
            )
            
        }
    }
    weak var presenterDelegate : SearchViewDelegate?
    {
        didSet
        {
            setupViews()
        }
    }
    init()
    {
        print("Class SearchView init/deinit +")
        super.init(frame: .zero)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        print("Class SearchView init/deinit -")
    }
    
    func setupViews()
    {
        backgroundColor = Appearance.shared.color.backgroundColor
        
        self.addSubview(searchTextFieldBaseView)
        searchTextFieldBaseView.backgroundColor = Appearance.shared.color.elevatedColor
        searchTextFieldBaseView.layer.cornerRadius = 10
        searchTextField.returnKeyType = .done
        searchTextField.delegate = self
        
        searchTextFieldBaseView.addSubview(searchTextField)
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: ((searchType == .ALLMOVIES) ? "Search all movies" : "Search all favorites"),
            attributes: [NSAttributedString.Key.foregroundColor: Appearance.shared.color.lowEmphasis_Light]
        )
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        searchTextFieldBaseView.addSubview(backNavigationButton)
        backNavigationButton.setImage(Appearance.shared.images.arrowBack, for: .normal)
        backNavigationButton.addTarget(self, action: #selector(closeSearchView), for: .touchUpInside)
        
        self.addSubview(ratingsFilterScrollView)
        ratingsFilterScrollView.showsHorizontalScrollIndicator = false
        ratingsFilterScrollView.addSubview(rated1StarButton)
        rated1StarButton.addTarget(self, action: #selector(rated1StarButtonAction), for: .touchUpInside)
        ratingsFilterScrollView.addSubview(rated2StarButton)
        rated2StarButton.addTarget(self, action: #selector(rated2StarButtonAction), for: .touchUpInside)
        ratingsFilterScrollView.addSubview(rated3StarButton)
        rated3StarButton.addTarget(self, action: #selector(rated3StarButtonAction), for: .touchUpInside)
        ratingsFilterScrollView.addSubview(rated4StarButton)
        rated4StarButton.addTarget(self, action: #selector(rated4StarButtonAction), for: .touchUpInside)
        ratingsFilterScrollView.addSubview(rated5StarButton)
        rated5StarButton.addTarget(self, action: #selector(rated5StarButtonAction), for: .touchUpInside)
        
        self.addSubview(emptyStateImageView)
        emptyStateImageView.isHidden = true
        
        self.addSubview(searchTableView)
        searchTableView.backgroundColor = .clear
        searchTableView.contentInsetAdjustmentBehavior = .never
        searchTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.tableHeaderView = nil

        addLayoutConstraints()
    }
    func addLayoutConstraints()
    {
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top ?? 20
        
        
        searchTextFieldBaseView.translatesAutoresizingMaskIntoConstraints = false
        searchTextFieldBaseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20 + topPadding).isActive = true
        searchTextFieldBaseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        searchTextFieldBaseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        searchTextFieldBaseView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.topAnchor.constraint(equalTo: searchTextFieldBaseView.topAnchor, constant: 10).isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: searchTextFieldBaseView.leadingAnchor, constant: 50).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        searchTextField.bottomAnchor.constraint(equalTo: searchTextFieldBaseView.bottomAnchor, constant: -10).isActive = true
        
        backNavigationButton.translatesAutoresizingMaskIntoConstraints = false
        backNavigationButton.topAnchor.constraint(equalTo: searchTextFieldBaseView.topAnchor, constant: 10).isActive = true
        backNavigationButton.leadingAnchor.constraint(equalTo: searchTextFieldBaseView.leadingAnchor, constant: 5).isActive = true
        backNavigationButton.trailingAnchor.constraint(equalTo: self.searchTextField.leadingAnchor, constant: -5).isActive = true
        backNavigationButton.bottomAnchor.constraint(equalTo: searchTextFieldBaseView.bottomAnchor, constant: -10).isActive = true
        
        ratingsFilterScrollView.translatesAutoresizingMaskIntoConstraints = false
        ratingsFilterScrollView.topAnchor.constraint(equalTo: searchTextFieldBaseView.bottomAnchor, constant: 15).isActive = true
        ratingsFilterScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        ratingsFilterScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        ratingsFilterScrollView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        rated5StarButton.translatesAutoresizingMaskIntoConstraints = false
        rated5StarButton.leadingAnchor.constraint(equalTo: ratingsFilterScrollView.leadingAnchor, constant: 30).isActive = true
        rated5StarButton.topAnchor.constraint(equalTo: ratingsFilterScrollView.topAnchor, constant: 0).isActive = true
        rated5StarButton.bottomAnchor.constraint(equalTo: ratingsFilterScrollView.bottomAnchor, constant: 0).isActive = true
        rated5StarButton.widthAnchor.constraint(equalToConstant: 40 + (9 * 5) + (2 * 4)).isActive = true
        
        rated4StarButton.translatesAutoresizingMaskIntoConstraints = false
        rated4StarButton.leadingAnchor.constraint(equalTo: rated5StarButton.trailingAnchor, constant: 20).isActive = true
        rated4StarButton.topAnchor.constraint(equalTo: ratingsFilterScrollView.topAnchor, constant: 0).isActive = true
        rated4StarButton.bottomAnchor.constraint(equalTo: ratingsFilterScrollView.bottomAnchor, constant: 0).isActive = true
        rated4StarButton.widthAnchor.constraint(equalToConstant: 40 + (9 * 4) + (2 * 3)).isActive = true
        
        rated3StarButton.translatesAutoresizingMaskIntoConstraints = false
        rated3StarButton.leadingAnchor.constraint(equalTo: rated4StarButton.trailingAnchor, constant: 20).isActive = true
        rated3StarButton.topAnchor.constraint(equalTo: ratingsFilterScrollView.topAnchor, constant: 0).isActive = true
        rated3StarButton.bottomAnchor.constraint(equalTo: ratingsFilterScrollView.bottomAnchor, constant: 0).isActive = true
        rated3StarButton.widthAnchor.constraint(equalToConstant: 40 + (9 * 3) + (2 * 2)).isActive = true
        
        rated2StarButton.translatesAutoresizingMaskIntoConstraints = false
        rated2StarButton.leadingAnchor.constraint(equalTo: rated3StarButton.trailingAnchor, constant: 20).isActive = true
        rated2StarButton.topAnchor.constraint(equalTo: ratingsFilterScrollView.topAnchor, constant: 0).isActive = true
        rated2StarButton.bottomAnchor.constraint(equalTo: ratingsFilterScrollView.bottomAnchor, constant: 0).isActive = true
        rated2StarButton.widthAnchor.constraint(equalToConstant: 40 + (9 * 2) + (2 * 1)).isActive = true
        
        rated1StarButton.translatesAutoresizingMaskIntoConstraints = false
        rated1StarButton.leadingAnchor.constraint(equalTo: rated2StarButton.trailingAnchor, constant: 20).isActive = true
        rated1StarButton.topAnchor.constraint(equalTo: ratingsFilterScrollView.topAnchor, constant: 0).isActive = true
        rated1StarButton.bottomAnchor.constraint(equalTo: ratingsFilterScrollView.bottomAnchor, constant: 0).isActive = true
        rated1StarButton.widthAnchor.constraint(equalToConstant: 40 + 9).isActive = true
        
        emptyStateImageView.translatesAutoresizingMaskIntoConstraints = false
        emptyStateImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        emptyStateImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        emptyStateImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        emptyStateImageView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        searchTableView.topAnchor.constraint(equalTo: ratingsFilterScrollView.bottomAnchor, constant: 20).isActive = true
        searchTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        searchTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        searchTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 141
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCell(withIdentifier: "SEARCH") as! StaffPicksTableViewCell?
        if cell == nil
        {
            cell = StaffPicksTableViewCell(style: .default, reuseIdentifier: "SEARCH")
        }
        cell?.viewDelegate = self
        cell?.updateCell(movie: filteredList[indexPath.row])
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0
        {
            presenterDelegate?.openDetailsView(movie: filteredList[indexPath.row])
        }
    }
    override func layoutSubviews() {

        let sum : CGFloat = CGFloat(40 * 5) + CGFloat(9 * 15) + CGFloat(2 * 10)
        ratingsFilterScrollView.contentSize.width = sum + 30 + 20 + 20 + 20 + 20 + 30
    }
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            print("Notification: Keyboard will show")
            searchTableView.setBottomInset(to: keyboardHeight)
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        print("Notification: Keyboard will hide")
        searchTableView.setBottomInset(to: 0.0)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
    ///////////////////////////////////////////////////////////////////////////////// DELEGATE FUNCTIONS
    func getPicture(url : String, completion : @escaping(PicturesType)->Void)
    {
        presenterDelegate!.getPicture(url: url, completion: completion)
    }
    @objc func closeSearchView()
    {
        presenterDelegate!.closeSearchView()
    }
    func setBookMark(selected: Bool, movieID: Int) {
        presenterDelegate?.setBookMark(selected: selected, movieID: movieID)
    }
    func reloadData()
    {
        filteredList = presenterDelegate!.getMoviesList(rating : ratingFilters, searchText : searchTextField.text ?? "", type: searchType)
        rated1StarButton.set(selected: false)
        rated2StarButton.set(selected: false)
        rated3StarButton.set(selected: false)
        rated4StarButton.set(selected: false)
        rated5StarButton.set(selected: false)
        if ratingFilters.contains(._1Star){
            rated1StarButton.set(selected: true)
        }
        if ratingFilters.contains(._2Star){
            rated2StarButton.set(selected: true)
        }
        if ratingFilters.contains(._3Star){
            rated3StarButton.set(selected: true)
        }
        if ratingFilters.contains(._4Star){
            rated4StarButton.set(selected: true)
        }
        if ratingFilters.contains(._5Star){
            rated5StarButton.set(selected: true)
        }
        searchTableView.reloadData()
        if filteredList.count == 0
        {
            searchTableView.isHidden = true
            emptyStateImageView.isHidden = false
        }
        else{
            searchTableView.isHidden = false
            emptyStateImageView.isHidden = true
        }
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        reloadData()
    }
    @objc func rated1StarButtonAction()
    {
        let idx = ratingFilters.firstIndex{$0 == ._1Star}
        if idx != nil{
            ratingFilters.remove(at: idx!)
        }
        else{
            ratingFilters.append(._1Star)
        }
        reloadData()
    }
    @objc func rated2StarButtonAction()
    {
        let idx = ratingFilters.firstIndex{$0 == ._2Star}
        if idx != nil{
            ratingFilters.remove(at: idx!)
        }
        else{
            ratingFilters.append(._2Star)
        }
        reloadData()
    }
    @objc func rated3StarButtonAction()
    {
        let idx = ratingFilters.firstIndex{$0 == ._3Star}
        if idx != nil{
            ratingFilters.remove(at: idx!)
        }
        else{
            ratingFilters.append(._3Star)
        }
        reloadData()
    }
    @objc func rated4StarButtonAction()
    {
        let idx = ratingFilters.firstIndex{$0 == ._4Star}
        if idx != nil{
            ratingFilters.remove(at: idx!)
        }
        else{
            ratingFilters.append(._4Star)
        }
        reloadData()
    }
    @objc func rated5StarButtonAction()
    {
        let idx = ratingFilters.firstIndex{$0 == ._5Star}
        if idx != nil{
            ratingFilters.remove(at: idx!)
        }
        else{
            ratingFilters.append(._5Star)
        }
        reloadData()
    }
}
