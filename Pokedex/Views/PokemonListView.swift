//
//  PokemonListView.swift
//  Pokedex
//
//  Created by Kevin on 5/17/23.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject private var viewModel = PokemonListViewModel()
    @State private var searchText = String()
    
    var searchResults: [Pokemon] {
        if searchText.isEmpty {
            return viewModel.pokemonList
        } else {
            return viewModel.pokemonList.filter {
                $0.name.capitalized.contains(searchText) }
        }
    }
    
    var body: some View {
        VStack {
            Text("PoKeMoN")
                .font(.custom("Pokemon Solid", size: 80))
                .foregroundColor(.yellow)
            NavigationStack {
                List(searchResults, id: \.id) {pokemon in
                    VStack(alignment: .leading) {
                        NavigationLink(destination: PokemonView(pokemon: pokemon)) {
                            Text(pokemon.name.capitalized)
                                .font(.headline)
                            Spacer()
                        }
                    }
                }
                .searchable(text: $searchText)
                .task {
                    await viewModel.getPokemonListData()
                }
            }
        }
        .background(.red)
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}

