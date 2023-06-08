//
//  DetailViewModel.swift
//  DisneyUIkit
//
//  Created by Ayberk Öz on 7.06.2023.
//

import Foundation

class DetailViewModel {
    
    let disney: DisneyModel1
    
    init(_ disney: DisneyModel1) {
        self.disney = disney
    }
    
    var filmArray: [String] {
        return disney.films
    }
    
    var shortFilmsArray: [String] {
        return disney.shortFilms
    }
    
    var alliesArray: [String] {
        return disney.allies
    }
    
    var enemiesArray: [String] {
        return disney.enemies
    }

}
