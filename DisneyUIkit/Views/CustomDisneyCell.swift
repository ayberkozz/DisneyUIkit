//
//  CustomDisneyCell.swift
//  DisneyUIkit
//
//  Created by Ayberk Öz on 26.05.2023.
//

import UIKit
import SDWebImage

class CustomDisneyCell: UITableViewCell {
    

    static let identifier = "CustomCell"
    private(set) var disney: DisneyModel1!

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
        characterImage.clipsToBounds = true
        return characterImage
    }()
    
    private let nameLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        nameLabel.font = .systemFont(ofSize: 24, weight: .medium)
        return nameLabel
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        characterImage.layer.cornerRadius = characterImage.frame.size.width / 2
    }

    
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

            characterImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            characterImage.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            characterImage.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            characterImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            
        ])
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with disney:DisneyModel1) {
        self.disney = disney
        self.nameLabel.text = disney.name
        self.characterImage.sd_setImage(with: URL(string:disney.imageURL))
    }
    
    //MARK: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
        self.characterImage.image = nil
    }
}


