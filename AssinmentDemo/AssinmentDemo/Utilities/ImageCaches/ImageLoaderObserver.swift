//
//  
//
//
//
//

import Foundation
import UIKit
import Combine

final class ImageCache {
    private init() { }
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    static var shared = ImageCache()
}

final class ImageObserver: ObservableObject {
    @Published var image:UIImage = UIImage(systemName:"photo.circle")! //placeholder image // ArtistImageTwo
    var cancelables = Set<AnyCancellable>()
    
    var imageCache = ImageCache.shared
    
    func fetchImageData(imageURL:String,placeholderImage:String? = nil) {
        if let placeholderImage {
            self.image = UIImage(named:placeholderImage)!
        }
        if let image = imageCache.get(forKey: imageURL) {
            self.image = image
        }
        else {
            guard let url = URL(string: imageURL) else { return }
            URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .sink {  completion in
                } receiveValue: { (data: Data, response: URLResponse) in
                    guard let image = UIImage(data: data)  else {
                        if let placeholderImage {
                            self.image = UIImage(named:placeholderImage)!
                        }
                        return
                    }
                    self.imageCache.set(forKey: imageURL, image: image)
                    self.image = UIImage(data: data) ?? self.image
                }
                .store(in: &cancelables)
        }
        
    }
}
