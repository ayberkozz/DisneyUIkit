//
//  ViewController.swift
//  DisneyUIkit
//
//  Created by Ayberk Öz on 23.05.2023.
//

import UIKit

class DisneyMainVC: UIViewController,DisneyViewModelOutput {
    
    let tableView = UITableView()
    
    private let viewModel : DisneyViewModel
    private var characterNames: [String] = []
    private var characterImages : [URL] = []
    
    
    init(viewModel: DisneyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func updateView(name: String, characterImageURL: URL) {
//        characterNames.append(name)
//        characterImages.append(characterImageURL)
//        tableView.reloadData()
//    }
    
    func updateView(name: String) {
        characterNames.append(name)
//        characterImages.append(characterImageURL)
        tableView.reloadData()
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.fetchCharacters()
        
        style()
        layout()
    }
    
    private func style(){
        title = "Disney Characters"
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = false
        tableView.register(CustomDisneyCell.self, forCellReuseIdentifier: CustomDisneyCell.identifier)
        
    }
    
    private func layout() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([

            tableView.heightAnchor.constraint(equalToConstant: view.frame.height),
            tableView.widthAnchor.constraint(equalToConstant: view.frame.width),
        ])
        
    }


}

//MARK: - Table View
extension DisneyMainVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomDisneyCell.identifier, for: indexPath) as? CustomDisneyCell else {
            fatalError("The Table View Could not a custom cell in vc")
        }
        
        let nameLabel = self.characterNames[indexPath.row]
//        let characterImage = self.characterImages[indexPath.row]
//        cell.configure(with: nameLabel, and: characterImage)
        cell.configure(with: nameLabel)
        
        return cell
    }


}

