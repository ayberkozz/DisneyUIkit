//
//  CustomCollectionViewCell.swift
//  DisneyUIkit
//
//  Created by Ayberk Öz on 8.06.2023.
//

import UIKit
import SDWebImage

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    private(set) var disney: DisneyModel1!
    
    private let Vstack : UIStackView = {
        let Vstack = UIStackView()
        Vstack.axis = .vertical
        Vstack.spacing = 3
        Vstack.alignment = .center
        return Vstack
    }()
    
    private let characterImage : UIImageView = {
        let characterImage = UIImageView()
        characterImage.contentMode = .scaleAspectFit
        characterImage.clipsToBounds = true
        return characterImage
    }()
    
    private let nameLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
        nameLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 20
        characterImage.layer.cornerRadius = 20
    }
    
    func layout() {
        
        contentView.backgroundColor = UIColor(red: 0.00, green: 0.42, blue: 0.60, alpha: 1.00)
        contentView.addSubview(Vstack)
        
        Vstack.addArrangedSubview(characterImage)
        Vstack.addArrangedSubview(nameLabel)
        
        Vstack.translatesAutoresizingMaskIntoConstraints = false
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            Vstack.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            Vstack.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            Vstack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            characterImage.topAnchor.constraint(equalToSystemSpacingBelow: Vstack.topAnchor, multiplier: 1),
            characterImage.heightAnchor.constraint(equalToConstant: contentView.frame.size.height / 1.5),
            characterImage.widthAnchor.constraint(equalToConstant: contentView.frame.size.width / 1.2),
            characterImage.centerXAnchor.constraint(equalTo: Vstack.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: Vstack.centerXAnchor)

        ])
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
