//
//  PokemonInfoPanel.swift
//  PokeMaster
//
//  Created by DeGao on 2021/11/9.
//  Copyright © 2021 OneV's Den. All rights reserved.
//

import SwiftUI

struct PokemonInfoPanel: View {
    
    let model: PokemonViewModel
    
    var ablities: [AbilityViewModel] {
        AbilityViewModel.sample(pokemonID: model.id)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            topIndicator
            Header(model: model)
        }
    }
    
    var topIndicator: some View {
        RoundedRectangle(cornerRadius: 3)
            .frame(width: 40, height: 6)
            .opacity(0.2)
    }
}

extension PokemonInfoPanel {
    struct Header: View {
        let model: PokemonViewModel
        
        var body: some View {
            HStack(spacing: 18) {
                pokemonIcon
                nameField
                Divider()
                    .frame(width: 1, height: 44)
                    .foregroundColor(.black.opacity(0.1))
                
            }
        }
        
        var pokemonIcon: some View {
            Image("Pokemon-\(model.id)")
                .resizable()
                .frame(width: 68, height: 68)
        }
        
        var nameField: some View {
            VStack {
                Text(model.name)
                    .foregroundColor(model.color)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                Text(model.nameEN)
                    .foregroundColor(model.color)
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                Text(model.genus)
                    .foregroundColor(.gray)
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    .padding(.top, 10)
            }
        }
    }
}

struct PokemonInfoPanel_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoPanel(model: .sample(id: 1))
    }
}
