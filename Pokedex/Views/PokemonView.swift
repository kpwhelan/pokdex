//
//  PokemonView.swift
//  Pokedex
//
//  Created by Kevin on 5/17/23.
//

import SwiftUI

struct PokemonView: View {
    @ObservedObject private var viewModel: PokemonViewModel
    
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
                Text("Description")
                    .font(.headline)
                Spacer(minLength:
                        20)
                Text(viewModel.pokemon.description)
                    .font(.body)
            }
            .padding()
        }
        .task {
            await viewModel.getPokemonData()
        }
//        .onAppear {
//            DispatchQueue.main.async {
//                viewModel.pokemon = self.pokemon
//            }
//        }
    }
}

//struct PokemonView_Previews: PreviewProvider {
//    static var previews: some View {
//        PokemonView(url: "test/url", name: "testName")
//    }
//}
