//
//  ViewController.swift
//  DisneyUIkit
//
//  Created by Ayberk Öz on 23.05.2023.
//

import UIKit

class DisneyMainVC: UIViewController,DisneyViewModelOutput {
    
    var collectionView : UICollectionView!
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let viewModel : DisneyViewModel
    private lazy var characters: [DisneyModel1] = []

    init(viewModel: DisneyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(values: [DisneyModel1]) {
        characters = values
        self.collectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchCharacters()
        
        style()
        layout()
        setupSearchController()
    }
    
    private func style(){
        title = "Disney Characters"
        
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func layout() {
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }

    private func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Character"
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(UIImage(systemName: "line.horizontal.3.decrease"), for: .bookmark, state: .normal)
    }
}

//MARK: - Search Controller Functions

extension DisneyMainVC: UISearchResultsUpdating,UISearchControllerDelegate, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.viewModel.updateSearchController(searchBarText: searchController.searchBar.text)
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("Search bar button called!")
    }
}

//MARK: - Collection View
extension DisneyMainVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let inSearchMode = self.viewModel.inSerchMode(searchController)
        return inSearchMode ? self.viewModel.filteredCharacters.count : self.viewModel.AllCharacters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        let inSearchMode = self.viewModel.inSerchMode(searchController)
        let disney = inSearchMode ? self.viewModel.filteredCharacters[indexPath.row] : self.viewModel.AllCharacters[indexPath.row]
        cell.configure(with: disney)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2-20, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let inSearchMode = self.viewModel.inSerchMode(searchController)
        let disney = inSearchMode ? self.viewModel.filteredCharacters[indexPath.row] : self.viewModel.AllCharacters[indexPath.row]
        let vm = DetailViewModel(disney)
        let vc = DetailVC(vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


