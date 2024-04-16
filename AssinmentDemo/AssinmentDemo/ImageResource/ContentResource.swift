//

//
//
//

import Foundation

struct ContentResource {
    
    func getAuthenticate(completionHandler:@escaping(_ result:contents?) -> Void) {
        let urlRequest = URLRequest(url:URL(string: BaseUrl + UrlUtility.content)!)

        HttpUtility.sharedInstance.postData(urlRequest: urlRequest, requestType: contents.self) { result in
            _ = completionHandler(result)
        }
        
    }
    
}
