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
    
    var abilities: [AbilityViewModel] {
        AbilityViewModel.sample(pokemonID: model.id)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            topIndicator
            Header(model: model)
            descriptionField
            Divider()
            AbilityList(model: model, abilityViewModels: abilities)
        }
        .padding(.init(top: 12, leading: 30, bottom: 30, trailing: 30))
        .background(.thinMaterial)
        .cornerRadius(20)
        .fixedSize(horizontal: false, vertical: true)
    }
    
    private var topIndicator: some View {
        RoundedRectangle(cornerRadius: 3)
            .frame(width: 40, height: 6)
            .opacity(0.2)
    }
    
    private var descriptionField: some View {
        Text(model.descriptionText)
            .font(.callout)
            .foregroundColor(.init(hex: 0x666666))
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)
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
                VStack(spacing: 12) {
                    bodyField
                    typeField
                }
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
                Spacer()
                Text(model.genus)
                    .foregroundColor(.gray)
                    .font(.system(size: 13))
                    .fontWeight(.bold)
            }
        }
        
        var typeField: some View {
            HStack {
                ForEach(model.types) { t in
                    typeTag(title: t.name, color: t.color)
                }
            }
        }
        
        var bodyField: some View {
            VStack {
                bodyInfo(tag: "身高", value: model.height)
                bodyInfo(tag: "体重", value: model.weight)
            }
        }
        
        func bodyInfo(tag: String, value: String) -> some View {
            HStack {
                bodyTag(tag)
                    .foregroundColor(.gray)
                bodyTag(value)
                    .foregroundColor(model.color)
            }
        }
        
        func bodyTag(_ tag: String) -> some View {
            Text(tag)
                .font(.system(size: 11))
        }
        
        func typeTag(title: String, color: Color) -> some View {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .foregroundColor(color)
                Text(title)
                    .font(.system(size: 10))
                    .foregroundColor(.white)
            }
            .frame(width: 36, height: 14)
        }
    }
}

struct PokemonInfoPanel_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoPanel(model: .sample(id: 1))
    }
}
