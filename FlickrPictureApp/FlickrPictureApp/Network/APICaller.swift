//
//  APICaller.swift
//  FlickrPictureApp
//
//  Created by  Decagon on 22/11/2021.
//

import Foundation

final class APICaller {
    // MARK: - Properties
    static let shared = APICaller()
    
    struct Constants {
        static let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.people.getPublicPhotos&api_key=56e779b053994c656ecbef2b4ecc9266&user_id=65789667%40N06&extras=url_m%2Cowner_name&format=json&nojsoncallback=1")
    }
    
    // MARK: - METHOD
    public func fetchData(completion: @escaping (Result<Photos, Error>) -> Void) {
        guard let url = Constants.url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.photos))
                    print(result.photos.photo[0].id)
                    print(result.photos.photo[0].title)
                    print(result.photos.photo[0].imageURL)
                }
                catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
