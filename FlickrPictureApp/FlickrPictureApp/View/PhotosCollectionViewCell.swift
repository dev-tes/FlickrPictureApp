//
//  PhotosCollectionViewCell.swift
//  FlickrPictureApp
//
//  Created by Tes on 22/11/2021.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotosCollectionViewCell"
    private var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        imageView.backgroundColor = .systemYellow
        return imageView
    }()
    
    private var favouriteIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.circle")
        imageView.backgroundColor = .systemYellow
        return imageView
    }()
    
    private var imageTitleLabel: UILabel = {
        let title = UILabel()
        title.text = "Image title"
        title.backgroundColor = .systemGreen
        return title
    }()
    
    private var ownersNameLabel: UILabel = {
        let title = UILabel()
        title.text = "John Doe"
        title.backgroundColor = .systemGreen
        return title
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemRed
        contentView.addSubview(myImageView)
        contentView.addSubview(imageTitleLabel)
        contentView.addSubview(ownersNameLabel)
        contentView.addSubview(favouriteIcon)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        customizeConstraint()
    }
    
    func customizeConstraint() {
        myImageView.frame = contentView.frame
        NSLayoutConstraint.activate([
            favouriteIcon.topAnchor.constraint(equalTo: myImageView.topAnchor, constant: 10),
            favouriteIcon.trailingAnchor.constraint(equalTo: myImageView.trailingAnchor, constant: 10),
            
            imageTitleLabel.bottomAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: -30),
            imageTitleLabel.leadingAnchor.constraint(equalTo: myImageView.leadingAnchor, constant: 10),
            
            ownersNameLabel.bottomAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: -10),
            ownersNameLabel.leadingAnchor.constraint(equalTo: imageTitleLabel.leadingAnchor)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
