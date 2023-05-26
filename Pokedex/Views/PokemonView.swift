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
                Spacer(minLength: 20)
                
                HStack {
                    Text("Description:")
                        .fontWeight(.bold)
                    Button("Read") {
                        showDescription.toggle()
                    }
                    .sheet(isPresented: $showDescription) {
                        PokemonDescription(description: viewModel.pokemon.description, name: viewModel.pokemon.name)
                    }
                }
                Spacer()
                Group {
                    RowDataView(rowName: "Type(s)", data: viewModel.pokemon.types.joined(separator: "\n"))
                    RowDataView(rowName: "Height:", data: String(viewModel.pokemon.height))
                    RowDataView(rowName: "Base Experience", data: String(viewModel.pokemon.baseExperience))
                    RowDataView(rowName: "Base Happiness:", data: String(viewModel.pokemon.baseHappiness))
                    RowDataView(rowName: "Capture Rate:", data: String(viewModel.pokemon.captureRate))
                    RowDataView(rowName: "Mythical:", data: String(viewModel.pokemon.isMythical).capitalized)
                    RowDataView(rowName: "Legendary:", data: String(viewModel.pokemon.isLegendary).capitalized)
                    RowDataView(rowName: "Moves:", data: viewModel.pokemon.moves.joined(separator: "\n"))
                }
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
