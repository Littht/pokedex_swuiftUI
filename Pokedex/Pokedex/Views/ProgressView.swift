//
//  ProgressView.swift
//  Pokedex
//
//  Created by Leonardo Benavides on 15/8/23.
//

import SwiftUI

struct ProgressView: View {
    
    var width:CGFloat = 150
    var height:CGFloat = 7
    
    @State var percent:CGFloat = 0
    @State var newPercent:CGFloat
    @State var color:Color = .red
    
    var body: some View {
        let multiplier = width / 255
        VStack{
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .frame(width: width, height: height)
                    .foregroundColor(.black.opacity(0.1))
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .frame(width:percent * multiplier, height: height)
                    .foregroundColor(color)
            }
            .animation(.spring(),value: percent * multiplier)
        }
        .onAppear{
            percent = newPercent
        }
        
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(newPercent: 100)
    }
}
