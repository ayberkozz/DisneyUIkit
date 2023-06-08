//
//  DisneyViewModel.swift
//  DisneyUIkit
//
//  Created by Ayberk Öz on 24.05.2023.
//

import Foundation
import UIKit

class DisneyViewModel {
    
    private let disneyService : DisneyService
    weak var output : DisneyViewModelOutput?
    
    private (set) var AllCharacters: [DisneyModel1] = [] {
        didSet {
            output?.updateView(values: AllCharacters)
        }
    }
    
    private(set) var filteredCharacters: [DisneyModel1] = []
    
    init(disneyService: DisneyService) {
        self.disneyService = disneyService
    }
    
    func fetchCharacters() {
        disneyService.fetchCharacters { [weak self] result in
            switch result {
            case .success(let character):
                self?.AllCharacters = character.data
//                self?.output?.updateView(values: character.data)
            case .failure(_):
                self?.AllCharacters = []
//                self?.output?.updateView(values: [])
            }
            
        }
    }
    
}

extension DisneyViewModel {
    public func inSerchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        
        return isActive && !searchText.isEmpty
    }
    
    
    public func updateSearchController(searchBarText: String?) {
        self.filteredCharacters = AllCharacters
        
        if let searchText = searchBarText?.lowercased() {
            guard !searchText.isEmpty else {self.output?.updateView(values: []); return}
            
            self.filteredCharacters = self.filteredCharacters.filter({
                $0.name.lowercased().contains(searchText)
            })
        }
        self.output?.updateView(values: self.AllCharacters)
    }

}
