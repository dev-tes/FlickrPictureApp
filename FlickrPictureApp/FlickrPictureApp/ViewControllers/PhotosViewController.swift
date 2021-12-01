//
//  ViewController.swift
//  FlickrPictureApp
//
//  Created by  Tes on 22/11/2021.
//

import UIKit
import CoreData

class PhotosViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: - Properties
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    private var persistedPhotos: [PersistedPhotos]?
    
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
        fetchPersistedPhotos()
        populateCollectionView()
    }
    
    // MARK: - METHODS
    func populateCollectionView() {
        APICaller.shared.fetchData { [weak self] data in
            
            switch data {
            case .success(let photo):
                self?.photos = photo.photo
                self?.persistedPhotos = (self?.photos.compactMap({
                    let newPersistencePhotos = PersistedPhotos(context: self?.context ?? NSManagedObjectContext())
                    newPersistencePhotos.ownersName = $0.ownername
                    newPersistencePhotos.titleOfImage = $0.title
                    newPersistencePhotos.isFavourite = false
                    newPersistencePhotos.image = $0.imageURL
                    
                    do {
                        try self?.context?.save()
                    }
                    catch {
                        
                    }
                    self?.fetchPersistedPhotos()
                    return newPersistencePhotos
                }))
                self?.viewModels = (self?.persistedPhotos?.compactMap({
                    PhotoCollectionViewCellViewModel(
                        title: $0.titleOfImage ?? "Tesleem",
                        ownername: $0.ownersName ?? " ",
                        imageURL: $0.image ?? " "
                    )
                }))!
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                
                // in case network fails
            case .failure(let error):
                
                // configure our viewmodel with what is in persistence
                self?.viewModels = (self?.persistedPhotos?.compactMap({
                    PhotoCollectionViewCellViewModel(
                        title: $0.titleOfImage ?? "Tesleem",
                        ownername: $0.ownersName ?? " ",
                        imageURL: $0.image ?? " "
                    )
                }))!
                
                //display it
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                        print("The error is \(error.localizedDescription)")
            }
        }
    }
    
    func fetchPersistedPhotos() {
        do {
            self.persistedPhotos = try context?.fetch(PersistedPhotos.fetchRequest())
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        catch {
            
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

