//
//  PokemonInfoRow.swift
//  PokeMaster
//
//  Created by DeGao on 2021/11/8.
//  Copyright © 2021 OneV's Den. All rights reserved.
//

import SwiftUI
import Kingfisher

struct PokemonInfoRow: View {
    let model: PokemonViewModel
    var expended: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                KFImage(model.iconImageURL)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 4)
                Spacer()
                VStack(alignment: .trailing) {
                    Text(model.name)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    Text(model.nameEN)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
            }
            .padding(.top, 12)
            Spacer()
            
            HStack(spacing: expended ? 20 : -30) {
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "star")
                        .modifier(ToolButtonModifier())
                }
                Button {
                    
                } label: {
                    Image(systemName: "chart.bar")
                        .modifier(ToolButtonModifier())
                }
                Button {
                    
                } label: {
                    Image(systemName: "info.circle")
                        .modifier(ToolButtonModifier())
                }
            }
            .padding(.bottom, 12)
            .opacity(expended ? 1 : 0)
            .frame(maxHeight: expended ? .infinity : 0)
        }
        .frame(height: expended ? 120 : 80)
        .padding(.leading, 23)
        .padding(.trailing, 15)
        .background(ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(model.color, style: .init(lineWidth: 4))
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient: .init(colors: [.white, model.color]), startPoint: .leading, endPoint: .trailing))
                
        })
        .padding(.horizontal)
    }
}

struct PokemonInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PokemonInfoRow(model: .sample(id: 1))
            PokemonInfoRow(model: .sample(id: 21))
            PokemonInfoRow(model: .sample(id: 25))
        }
    }
}
