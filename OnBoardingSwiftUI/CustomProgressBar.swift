//
//  CustomProgressBar.swift
//  OnBoardingSwiftUI
//
//  Created by Mac on 02/07/2021.
//

import SwiftUI

struct CustomProgressBar: View {
    
    @Binding var percentage: CGFloat
    
    var body: some View {
        
        VStack {
            
            ZStack(alignment: .leading) {
                
                Capsule()
                    .fill(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.18))
                    .frame(width: 250, height: 20)
                    
                Capsule()
                    .fill(Color(#colorLiteral(red: 0.9313160181, green: 0.6680327058, blue: 0.4836443067, alpha: 1)))
                    .frame(width: percentage * 250, height: 20)
                
            }
        }
        .padding()
    }
}
