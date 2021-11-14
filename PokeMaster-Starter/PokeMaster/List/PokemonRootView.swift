//
//  PokemonRootView.swift
//  PokeMaster
//
//  Created by 郝振壹 on 2021/11/14.
//  Copyright © 2021 OneV's Den. All rights reserved.
//

import SwiftUI

struct PokemonRootView: View {
    @State var searchText: String = ""

    var body: some View {
        NavigationView {
            PokemonList()
        }
        .searchable(text: $searchText, prompt: "")
    }
}

struct PokemonRootView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRootView()
    }
}
