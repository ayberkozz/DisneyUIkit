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
                for disneyModel1 in character.data {
//                    self?.output?.updateView(name: disneyModel1.name, characterImageURL: URL(string:disneyModel1.imageURL)!)
//                    self?.output?.updateView(name: disneyModel1.name)
                    self?.output?.updateView(values: character.data)
                }
            case .failure(_):
//                self?.output?.updateView(name: "No user", characterImageURL: URL(string: "")!)
//                self?.output?.updateView(name: "No user", characterImageURL: URL(string: "https://picsum.photos/200/300")!)
                self?.output?.updateView(values: [])
            }
            
        }
    }
    
}
