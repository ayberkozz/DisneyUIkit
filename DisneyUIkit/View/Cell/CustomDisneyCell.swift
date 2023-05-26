//
//  CustomDisneyCell.swift
//  DisneyUIkit
//
//  Created by Ayberk Öz on 26.05.2023.
//

import UIKit

class CustomDisneyCell: UITableViewCell {
    

    static let identifier = "CustomCell"
    
    private let Hstack : UIStackView = {
        let Hstack = UIStackView()
        Hstack.axis = .horizontal
        Hstack.spacing = 5
        Hstack.alignment = .leading
        return Hstack
    }()
    
    private let characterImage : UIImageView = {
        let characterImage = UIImageView()
        characterImage.contentMode = .scaleAspectFit
        return characterImage
    }()
    
    private let nameLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        nameLabel.font = .systemFont(ofSize: 24, weight: .medium)
        return nameLabel
    }()
    
    func layout() {
        
        self.contentView.addSubview(Hstack)
        
        Hstack.addArrangedSubview(characterImage)
        Hstack.addArrangedSubview(nameLabel)
        
        Hstack.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.backgroundColor = .white
        
        NSLayoutConstraint.activate([

            Hstack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            Hstack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

        ])
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    public func configure(with nameLabel : String, and characterImage : UIImage) {
//        self.nameLabel.text = nameLabel
//        self.characterImage.image = characterImage
//    }
    
    public func configure(with nameLabel : String) {
        self.nameLabel.text = nameLabel
    }
    
}

