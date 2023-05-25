//
//  DisneyViewModel.swift
//  DisneyUIkit
//
//  Created by Ayberk Öz on 24.05.2023.
//

import Foundation

class DisneyViewModel {
    
    private let disneyService : DisneyService
    weak var output : DisneyViewModelOutput?
    
    init(disneyService: DisneyService) {
        self.disneyService = disneyService
    }
    
    func fetchCharacters() {
        disneyService.fetchChracters { [weak self] result in
            switch result {
            case .success(let character):
                for disneyModel1 in character.data {
                    self?.output?.updateView(name: disneyModel1.name)
                }
            case .failure(_):
                self?.output?.updateView(name: "No user")
            }
            
        }
    }
    
}
