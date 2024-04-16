//
//
//
//
//  
//

import SwiftUI

struct ContentImageView: View {
  
    @StateObject var imageObserver = ImageObserver()
    var imageURL:String
    var placeholderImage:String?
    init(imageURL: String, placeholderImage:String? = nil) {
        self.imageURL = imageURL
        self.placeholderImage = placeholderImage
    }
    
    var body: some View {
        
        GeometryReader { proxy in
            
            Image(uiImage: imageObserver.image)
                .resizable()
                .onAppear {
                   
                    self.imageObserver.fetchImageData(imageURL: imageURL,placeholderImage: self.placeholderImage)
                }
        }
        
    }
}
