//
//  ContentView.swift
//  OnBoardingSwiftUI
//
//  Created by Mac on 30/06/2021.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage ("currentPage") var currentPage = 1
    @StateObject var globalVars = GlobalVars()
    @State var percentage: CGFloat = 0.0
    
    var body: some View {
        
        ZStack {
            
            if currentPage == 1 {
                
                onBoardingView(welcomeText: "Welcome", image: "Image1", title: "Products from worldwide", description: "Add some description for you page1 and let user know what is happening here", backgroundColor: Color(#colorLiteral(red: 0.2790315449, green: 0.4796082377, blue: 0.4475283027, alpha: 1)), globalVars: globalVars, percentage: $percentage)
                    .transition(.scale)
                
            }
            
            if currentPage == 2 {
                
                onBoardingView(welcomeText: "Welcome", image: "Image2", title: "Buy from anywhere", description: "Add some description for you page1 and let user know what is happening here", backgroundColor: Color(#colorLiteral(red: 0.2021480799, green: 0.3067737818, blue: 0.5766347647, alpha: 1)), globalVars: globalVars, percentage: $percentage)
                    .transition(.opacity)
            }
            
            if currentPage == 3 {
                
                onBoardingView(welcomeText: "Welcome", image: "Image3", title: "Buy from anywhere", description: "Add some description for you page1 and let user know what is happening here", backgroundColor: Color(#colorLiteral(red: 0.8510934711, green: 0.4118855, blue: 0.09938571602, alpha: 1)), globalVars: globalVars, percentage: $percentage)
                    .transition(.slide)
            }
            
            if currentPage == 4 {
                
                HomeScreen()
            }
            
        }
        .onAppear{
            
            percentage = CGFloat(currentPage)/CGFloat(GlobalVars.totalImages)
        }
        .overlay(
            
            Button(action: {
                
                if currentPage <= GlobalVars.totalImages {
                    
                    withAnimation(.easeInOut) {
                        
                        currentPage += 1
                        percentage = CGFloat(currentPage)/CGFloat(GlobalVars.totalImages)
                        
                        if currentPage == GlobalVars.totalImages  {
                            globalVars.butttonText = "Get Started"
                        }
                        
                        if currentPage == GlobalVars.totalImages + 1  {
                            globalVars.ButtonOpacity = 0.0
                        }
                    }
                    
                } else {
                    
                    currentPage = 4
                }
                
            }, label: {
                
                VStack {
                    
                    Text(globalVars.butttonText)
                        .frame(width: 260, height: 50)
                        .clipShape(Rectangle())
                        .foregroundColor(.white)
                        .background(Color(#colorLiteral(red: 0.9294117647, green: 0.6680327058, blue: 0.4836443067, alpha: 1)))
                        .font(.title2)
                        .cornerRadius(25)
                        .opacity(globalVars.ButtonOpacity)
                    
                    CustomProgressBar(percentage: $percentage)
                    
                }
            })
            .opacity(globalVars.ButtonOpacity)
            .padding()
            ,alignment: .bottom
            
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct onBoardingView: View {
    
    let welcomeText: String
    let image: String
    let title: String
    let description: String
    let backgroundColor: Color
    
    @StateObject var globalVars: GlobalVars
    @Binding var percentage: CGFloat
    @AppStorage ("currentPage") var currentPage = 1
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            HStack {
                
                if currentPage == 1 {
                    
                    Text(welcomeText)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                } else {
                    
                    Button(action: {
                        
                        withAnimation(.easeInOut) {
                            
                            globalVars.butttonText = "Next"
                            currentPage -= 1
                            percentage = CGFloat(currentPage)/CGFloat(GlobalVars.totalImages)
                            
                        }
                        
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(8)
                    })
                }
                
                Spacer()
                
                Button(action: {
                    
                    globalVars.ButtonOpacity = 0.0
                    currentPage = 4
                    
                }, label: {
                    Text("Skip")
                        .font(.title2)
                        .foregroundColor(.white)
                })
            }
            .foregroundColor(.black)
            .padding()
            .padding(.top, 30)
            
            VStack(spacing: 20) {
                
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text(title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Text(description)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
            }
            .padding(.top, 50)
            Spacer()
        }
        .background(backgroundColor).ignoresSafeArea()
    }
}

extension Double {
    
    func rounded(toPlaces places:Int) -> Double {
        
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

class GlobalVars: ObservableObject {
    @Published var butttonText = "Next"
    @Published var ButtonOpacity = 0.8
    static var totalImages = 3
    
}
