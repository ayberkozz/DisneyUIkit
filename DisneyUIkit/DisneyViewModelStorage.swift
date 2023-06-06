//
//  DisneyViewModelStorage.swift
//  DisneyUIkit
//
//  Created by Ayberk Öz on 25.05.2023.
//

import Foundation
import UIKit

protocol DisneyViewModelOutput : AnyObject {
    func updateView(values: [DisneyModel1])
}
