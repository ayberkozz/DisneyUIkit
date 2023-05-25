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

    func updateView(name: String) {
        characterNames.append(name)
        tableView.reloadData()
    }
    
    
    init(viewModel: DisneyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        viewModel.fetchCharacters()
        
        style()
        layout()
    }
    
    func style(){
        tableView.frame = view.bounds
        title = "Disney Characters"
    }
    
    func layout() {
        
        view.addSubview(tableView)
        
//        NSLayoutConstraint.activate([
//
//            tableView.heightAnchor.constraint(equalToConstant: view.frame.height),
//            tableView.widthAnchor.constraint(equalToConstant: view.frame.width),
//        ])
        
    }


}

//MARK: - Table View
extension DisneyMainVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = characterNames[indexPath.row]
        return cell
    }


}

