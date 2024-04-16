//

//

//
//  
//
//
//
//

import SwiftUI

struct CheckInternetConnt: View {
    
    @State private var alertVisible: Bool = false
    
    var body: some View {
        ZStack{
            Color.black
            Spacer()
            VStack(spacing: 20) {
                Image("ErrorImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .cornerRadius(20)
                
                Text("Something went wrong please check internet connection")
                    .titleStyle(textStyle: "Bold", fontSize: 26, foregroundColor: .white)
                
                Text("We're having issues loading this page")
                    .titleStyle(textStyle: "Regular", fontSize: 20, foregroundColor: .white)
                
                Button {
                    alertVisible.toggle()
                } label: {
                    Text("Try again")
                        .titleStyle(textStyle: "Regular", fontSize: 16, foregroundColor: .blue)
                        .padding(.horizontal, 14)
                        .padding(.vertical,8)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(.blue, lineWidth: 1)
                        }
                    
                }
                .alert(isPresented: $alertVisible) {
                    Alert (title: Text("Go to Settings"),
                           message: Text("Wanna go to settings to check connectivity?"),
                           primaryButton: .default(Text("Settings"), action: {
                        if let url = URL(string:"App-Prefs:root=WIFI") {
                          if UIApplication.shared.canOpenURL(url) {
                            if #available(iOS 10.0, *) {
                              UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            } else {
                              UIApplication.shared.openURL(url)
                            }
                          }
                        }

                    }),
                           secondaryButton: .default(Text("Cancel")))
                }
                
            }
        }
        .background(Color.black)
        
    }
}

struct CheckInternetConnt_Previews: PreviewProvider {
    static var previews: some View {
        CheckInternetConnt()
    }
}

struct Title: ViewModifier {
    
    @State var textStyle: String
    @State var fontSize: CGFloat
    @State var foregroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.custom("Montserrat-\(textStyle)", size: fontSize))
            .foregroundColor(foregroundColor)
    }
    
}
extension View {
    func titleStyle(textStyle: String, fontSize: CGFloat, foregroundColor: Color) -> some View {
        modifier(Title(textStyle: textStyle, fontSize: fontSize, foregroundColor: foregroundColor))
    }
}
