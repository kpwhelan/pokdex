//
//  PokemonLogoView.swift
//  Pokedex
//
//  Created by Kevin on 5/20/23.
//

import SwiftUI

struct PokemonLogoView: View {
    var body: some View {
        Text("PoKéMoN")
            .font(.custom("Pokemon Solid", size: 90))
            .background(.red)
            .foregroundColor(.yellow)
    }
}

struct PokemonLogoView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonLogoView()
    }
}
