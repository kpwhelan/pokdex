//
//  PokemonListView.swift
//  Pokedex
//
//  Created by Kevin on 5/17/23.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject private var viewModel = PokemonListViewModel()
    
    var body: some View {
        VStack {
            Text("Pokemon")
                .font(.largeTitle)
            NavigationStack {
                List(viewModel.pokemonList, id: \.id) {pokemon in
                    VStack(alignment: .leading) {
                        NavigationLink(destination: PokemonView(pokemon: pokemon)) {
                            Text(pokemon.name.capitalized)
                                .font(.headline)
                            Spacer()
                        }
                    }
                }
                .task {
                    await viewModel.getPokemonListData()
                }
            }
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}

