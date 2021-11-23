//
//  ViewController.swift
//  FlickrPictureApp
//
//  Created by  Tes on 22/11/2021.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: - Properties
    private var photos = [Photo]()
    private var viewModels = [PhotoCollectionViewCellViewModel]()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height/3)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        collectionView.frame = view.bounds
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        view.addSubview(collectionView)
        title = "Photos"
        populateCollectionView()

    }
    
    // MARK: - METHODS
    func populateCollectionView() {
        APICaller.shared.fetchData { [weak self] data in
            
            switch data {
            case .success(let photo):
                print("The photo is \(photo.photo.count)")
                self?.photos = photo.photo
                self?.viewModels = (self?.photos.compactMap({
                    PhotoCollectionViewCellViewModel(
                        title: $0.title,
                        ownername: $0.ownername,
                        imageURL: $0.imageURL
                    )
                }))!
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                        print("The error is \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - ColllectionView Delegate and data source stubs
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell
        else { return UICollectionViewCell() }
        cell.configureCollectionView(with: viewModels[indexPath.row])
        return cell
    }

}

