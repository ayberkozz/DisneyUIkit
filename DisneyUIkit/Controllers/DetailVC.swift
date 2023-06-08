//
//  DetailVC.swift
//  DisneyUIkit
//
//  Created by Ayberk Öz on 7.06.2023.
//

import UIKit

class DetailVC: UIViewController {

    private let viewModel: DetailViewModel
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let vStack = UIStackView()
    private let FilmTableView = UITableView()
    private let ShortFilmTableView = UITableView()
    private let alliesTableView = UITableView()
    private let enemiesTableView = UITableView()
    
    init(_ viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        style()
        layout()
    }

    func style() {
        
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = self.viewModel.disney.name
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        

        FilmTableView.translatesAutoresizingMaskIntoConstraints = false
        FilmTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        FilmTableView.delegate = self
        FilmTableView.dataSource = self
        
        ShortFilmTableView.translatesAutoresizingMaskIntoConstraints = false
        ShortFilmTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellShortFilm")
        ShortFilmTableView.delegate = self
        ShortFilmTableView.dataSource = self
        
        alliesTableView.translatesAutoresizingMaskIntoConstraints = false
        alliesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellAllies")
        alliesTableView.delegate = self
        alliesTableView.dataSource = self
        
        enemiesTableView.translatesAutoresizingMaskIntoConstraints = false
        enemiesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellEnemies")
        enemiesTableView.delegate = self
        enemiesTableView.dataSource = self
    }
    
    func layout() {
        
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(FilmTableView)
        self.contentView.addSubview(ShortFilmTableView)
        self.contentView.addSubview(alliesTableView)
        self.contentView.addSubview(enemiesTableView)
        
        let height = contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor)
        height.priority = UILayoutPriority(1)
        height.isActive = true
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            FilmTableView.topAnchor.constraint(equalTo: contentView.topAnchor),
            FilmTableView.heightAnchor.constraint(equalToConstant: view.frame.height/4),
            FilmTableView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            ShortFilmTableView.topAnchor.constraint(equalToSystemSpacingBelow: FilmTableView.bottomAnchor, multiplier: 0),
            ShortFilmTableView.heightAnchor.constraint(equalToConstant: view.frame.height/4),
            ShortFilmTableView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            alliesTableView.topAnchor.constraint(equalToSystemSpacingBelow: ShortFilmTableView.bottomAnchor, multiplier: 0),
            alliesTableView.heightAnchor.constraint(equalToConstant: view.frame.height/4),
            alliesTableView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            enemiesTableView.topAnchor.constraint(equalToSystemSpacingBelow: alliesTableView.bottomAnchor, multiplier: 0),
            enemiesTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            enemiesTableView.heightAnchor.constraint(equalToConstant: view.frame.height/4),
            enemiesTableView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
        ])
        
    }
    
}

//MARK: - Table View
extension DetailVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == FilmTableView {
            return viewModel.filmArray.count == 0 ? 1 : viewModel.filmArray.count
        }
        else if tableView == ShortFilmTableView {
            return viewModel.shortFilmsArray.count == 0 ? 1 : viewModel.shortFilmsArray.count
        }
        else if tableView == alliesTableView {
            return viewModel.alliesArray.count == 0 ? 1 : viewModel.alliesArray.count
        }
        else if tableView == enemiesTableView {
            return viewModel.enemiesArray.count == 0 ? 1 : viewModel.enemiesArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == FilmTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
            cell.textLabel?.text = viewModel.filmArray.isEmpty ? "No films available" : viewModel.filmArray[indexPath.row]
            return cell
        }
        if tableView == ShortFilmTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellShortFilm",for: indexPath)
            cell.textLabel?.text = viewModel.shortFilmsArray.isEmpty ? "No short films available" : viewModel.shortFilmsArray[indexPath.row]
            return cell
        }
        else if tableView == alliesTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellAllies",for: indexPath)
            cell.textLabel?.text = viewModel.alliesArray.isEmpty ? "No Allies" : viewModel.alliesArray[indexPath.row]
            return cell
        }
        else if tableView == enemiesTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellEnemies",for: indexPath)
            cell.textLabel?.text = viewModel.enemiesArray.isEmpty ? "No Enemies" : viewModel.enemiesArray[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == FilmTableView {
            return "Films"
        }
        else if tableView == ShortFilmTableView {
            return "Short Films"
        }
        else if tableView == alliesTableView {
            return "Allies"
        }
        else if tableView == enemiesTableView {
            return "Enemies"
        }
        return ""
    }
}
