//
//  PokemonView.swift
//  Pokedex
//
//  Created by Kevin on 5/17/23.
//

import SwiftUI

struct PokemonView: View {
    @ObservedObject var viewModel: PokemonViewModel
    @State private var showDescription = false
    
    init(pokemon: Pokemon) {
        viewModel = PokemonViewModel(pokemon: pokemon)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: viewModel.pokemon.imageUrl))
                { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 300, height: 300)

                Text(self.viewModel.pokemon.name.capitalized)
                    .font(.largeTitle)
                Button("Description") {
                    showDescription.toggle()
                }
                .sheet(isPresented: $showDescription) {
                    PokemonDescription(description: viewModel.pokemon.description, name: viewModel.pokemon.name)
                }
                Spacer(minLength:
                        20)
            }
            .padding()
        }
        .task {
            await viewModel.getPokemonData()
        }
    }
}

//struct PokemonView_Previews: PreviewProvider {
//    static var previews: some View {
//        PokemonView(url: "test/url", name: "testName")
//    }
//}
