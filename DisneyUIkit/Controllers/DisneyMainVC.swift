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
    private lazy var characters: [DisneyModel1] = []

    
    init(viewModel: DisneyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(values: [DisneyModel1]) {
        characters = values
        self.tableView.reloadData()
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
        tableView.allowsSelection = true
        tableView.register(CustomDisneyCell.self, forCellReuseIdentifier: CustomDisneyCell.identifier)
        
    }
    
    private func layout() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }


}

//MARK: - Table View
extension DisneyMainVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomDisneyCell.identifier, for: indexPath) as? CustomDisneyCell else {
            fatalError("The Table View Could not a custom cell in vc")
        }
        
        cell.configure(with: characters[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)

        let vm = DetailViewModel(characters[indexPath.row])
        let vc = DetailVC(vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }


}

