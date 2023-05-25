//
//  DisneyService.swift
//  DisneyUIkit
//
//  Created by Ayberk Öz on 24.05.2023.
//

import Foundation

protocol DisneyServiceProtocol {
    func fetchChracters(completion: @escaping(Result<DisneyModel,Error>)->Void)
}

class DisneyService : DisneyServiceProtocol{
    
    func fetchChracters(completion: @escaping(Result<DisneyModel,Error>)->Void) {
        
        let url = URL(string: "https://api.disneyapi.dev/character")!
        
        URLSession.shared.dataTask(with: url) { data, response, err in
            
            guard let data = data else {return}
            DispatchQueue.main.async {
                if let character = try? JSONDecoder().decode(DisneyModel.self, from: data) {
                    completion(.success(character))
                } else {
                    completion(.failure(NSError()))
                }
            }
            
        }.resume()
        
    }
    
}
