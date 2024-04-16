//

//

import SwiftUI

struct ContentView: View {
    @StateObject var networkObserver = NetworkMonitor()
    @ObservedObject var contentVMObj:ContentViewModel = ContentViewModel()
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: gridItemLayout, content: {
                    
                    ForEach(contentVMObj.contentData ?? [],id: \.id) { value in
                        
                        let imageName = value.thumbnail.key
                        let domain = "\(value.thumbnail.domain)" + "/" + "\(value.thumbnail.basePath)" + "/" + "\(value.thumbnail.qualities[0])" + "/" + "\(imageName)"
                        ContentImageView(imageURL:domain)
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipped()
                        
                    }
                    
                })
            }
            if(contentVMObj.isLoading){
                ProgressView()
                    .scaleEffect(2)
            }
        }
        .overlay {
            if !networkObserver.isActive {
                
                CheckInternetConnt()
                
            }
            
            
        }
        .onAppear{
            contentVMObj.contentApiCall()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
