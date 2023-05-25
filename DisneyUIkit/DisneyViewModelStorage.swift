//
//  DisneyViewModelStorage.swift
//  DisneyUIkit
//
//  Created by Ayberk Öz on 25.05.2023.
//

import Foundation

protocol DisneyViewModelOutput : AnyObject {
    func updateView(name: String)
}
