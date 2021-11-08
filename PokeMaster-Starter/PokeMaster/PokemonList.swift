//
//  PokemonList.swift
//  PokeMaster
//
//  Created by DeGao on 2021/11/8.
//  Copyright © 2021 OneV's Den. All rights reserved.
//

import SwiftUI

struct PokemonList: View {
    var body: some View {
        List(PokemonViewModel.all) { pokemon in
            PokemonInfoRow(model: pokemon, expended: false)
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 4, leading: 0, bottom: 4, trailing: 0))
        }
        .listStyle(.plain)
        
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
