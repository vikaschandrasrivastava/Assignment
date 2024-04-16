

import Foundation

final class HttpUtility{
    
    static let sharedInstance = HttpUtility()
    private init(){
        
    }
    
    func postData<T:Decodable> (urlRequest:URLRequest,requestType:T.Type,completionHandler:@escaping(_ result:T?)-> Void) {
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            
            if(error == nil){
                if let data, let string = String(data: data, encoding: .utf8) {
                    print(string)
                }
                
                
                let response = try? JSONDecoder().decode(requestType.self, from: data!)
                
                _ =  completionHandler(response)
                
            }
            
        }.resume()
    }
}
