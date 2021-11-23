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
        return imageView
    }()
    
    private var favouriteIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.circle")
        imageView.tintColor = .white
        return imageView
    }()
    
    private var imageTitleLabel: UILabel = {
        let title = UILabel()
        title.text = "Image title"
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 20)
        title.font = UIFont.preferredFont(forTextStyle: .body)
        title.adjustsFontForContentSizeCategory = true
        return title
    }()
    
    private var ownersNameLabel: UILabel = {
        let title = UILabel()
        title.text = "John Doe"
        title.textColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 29.0)
        title.font = UIFont.preferredFont(forTextStyle: .title1)
        title.adjustsFontForContentSizeCategory = true
        return title
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemRed
        addSubview(myImageView)
        myImageView.addSubview(imageTitleLabel)
        addSubview(ownersNameLabel)
        myImageView.addSubview(favouriteIcon)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        customizeConstraint()
    }
    
    func customizeConstraint() {
        myImageView.frame = contentView.frame
        favouriteIcon.frame = CGRect(
            x: contentView.frame.size.width - 50,
            y: 10,
            width: 40,
            height: 40
        )
        imageTitleLabel.frame = CGRect(
            x: 10,
            y: contentView.frame.size.height - 50,
            width: contentView.frame.size.width - 40,
            height: 40
        )
        ownersNameLabel.frame = CGRect(
            x: 10,
            y: contentView.frame.size.height - 110,
            width: contentView.frame.size.width - 40,
            height: 70
        )
    }
    
    public func configureCollectionView(with viewModel: PhotoCollectionViewCellViewModel) {
        ownersNameLabel.text = viewModel.ownername
        imageTitleLabel.text = viewModel.title
        favouriteIcon.image = UIImage(systemName: "star.circle")
        let urlString = viewModel.imageURL
        
        if let data = viewModel.imageData {
            myImageView.image = UIImage(data: data)
        } else if let url = URL(string: urlString ?? "") {
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else { return}
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self.myImageView.image = UIImage(data: data)
                    print(data)
                }
            }.resume()
        }
    }
    
    override func prepareForReuse() {
        myImageView.image = nil
        imageTitleLabel.text = nil
        ownersNameLabel.text = nil
        favouriteIcon.image = nil
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
