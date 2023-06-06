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
    
    init(disneyService: DisneyService) {
        self.disneyService = disneyService
    }
    
    func fetchCharacters() {
        disneyService.fetchCharacters { [weak self] result in
            switch result {
            case .success(let character):
                self?.output?.updateView(values: character.data)
            case .failure(_):
                self?.output?.updateView(values: [])
            }
            
        }
    }
    
}
