//
//  PokemonList.swift
//  PokeMaster
//
//  Created by DeGao on 2021/11/8.
//  Copyright © 2021 OneV's Den. All rights reserved.
//

import SwiftUI

struct PokemonList: View {
    
    @State var expandingIndex: Int?
    
    var body: some View {
        List(PokemonViewModel.all) { pokemon in
            PokemonInfoRow(model: pokemon, expended: self.expandingIndex == pokemon.id)
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 4, leading: 0, bottom: 4, trailing: 0))
                .onTapGesture {
                    withAnimation {
                        if self.expandingIndex == pokemon.id {
                            self.expandingIndex = nil
                        } else {
                            self.expandingIndex = pokemon.id
                        }
                    }
                }
        }
        .listStyle(.plain)
        
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
