//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Kevin on 5/17/23.
//

import SwiftUI

final class PokemonListViewModel: ObservableObject {
    @Published var pokemonList = [Pokemon]()

    private var name = String()
    private var imageUrl = String()
    private var description = String()
    
    private let listUrl = "https://pokeapi.co/api/v2/pokemon?limit=10000"
    
    func getPokemonListData() async {
        guard let url = URL(string: listUrl) else {
            print("Bad list URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(ListResponse.self, from: data) {
                for result in decodedResponse.results {
                    DispatchQueue.main.async {
                        self.pokemonList.append(Pokemon(id: UUID(), name: result.name, imageUrl: String(), description: String(), types: [String](), baseHappiness: Int(), captureRate: Int(), isLegendary: Bool(), isMythical: Bool(), baseExperience: Int(), height: Int(), moves: [String]()))
                    }
                }
            }
        } catch {
            print(error.self)
        }
    }
}
