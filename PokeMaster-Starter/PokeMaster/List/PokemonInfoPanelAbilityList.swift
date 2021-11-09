//
//  PokemonInfoPanelAbilityList.swift
//  PokeMaster
//
//  Created by 郝振壹 on 2021/11/9.
//  Copyright © 2021 OneV's Den. All rights reserved.
//

import SwiftUI

extension PokemonInfoPanel {
    
    struct AbilityList: View {
        let model: PokemonViewModel
        var abilityViewModels: [AbilityViewModel]?
        
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text("技能")
                    .font(.headline)
                    .fontWeight(.bold)
                if let abilityViewModels = abilityViewModels {
                    ForEach(abilityViewModels) { abilityViewModel in
                        Text(abilityViewModel.name)
                            .font(.subheadline)
                            .foregroundColor(model.color)
                        Text(abilityViewModel.descriptionText)
                            .font(.footnote)
                            .foregroundColor(.init(hex: 0xAAAAAA))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct PokemonInfoPanelAbilityList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoPanel.AbilityList(model: .sample(id: 1))
    }
}
