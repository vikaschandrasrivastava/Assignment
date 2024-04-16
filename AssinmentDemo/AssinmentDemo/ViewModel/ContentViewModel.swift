//
// 
//
//
//

import Foundation
class ContentViewModel: ObservableObject {
    
    @Published var contentData:contents?
    @Published var showAlertView:Bool = false
    @Published var errorMessage:String = String()
    @Published var isLoading:Bool = false
    
    let contentObj:ContentResource = ContentResource()
    
    
    func contentApiCall()  {
        self.isLoading = true
        contentObj.getAuthenticate { result in
            
            DispatchQueue.main.async {
                if result?.count != nil {
                    
                    
                    self.contentData = result
                    self.showAlertView = false
                    self.isLoading = false
                    
                    
                }else{
                    self.errorMessage = ""
                    self.showAlertView = true
                    self.isLoading = false
                }
                
            }
            
        }
        
    }
    
    
    
}
