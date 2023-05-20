//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Kevin on 5/17/23.
//

import Foundation

@MainActor
final class PokemonViewModel: ObservableObject {
    @Published var pokemon: Pokemon
    
    private let spritesUrl = "https://pokeapi.co/api/v2/pokemon/"
    private let speciesUrl = "https://pokeapi.co/api/v2/pokemon-species/"
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    func getPokemonData() async {
        await getPokemonImageUrl()
        await getPokemonDescription()
    }
    
    func getPokemonImageUrl() async {
        guard let url = URL(string: "\(spritesUrl)\(pokemon.name)") else {
            print("No Pokemon URL provided")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(PokemonResponse.self, from: data) {
                pokemon.imageUrl = decodedResponse.sprites.other.home.front_default

            }
        } catch {
            print(error.self)
        }
    }
    
    func getPokemonDescription() async {
        guard let url = URL(string: "\(speciesUrl)\(pokemon.name)") else {
            print("Nothing found")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(PokemonInfoResponse.self, from: data) {
                for item in decodedResponse.flavor_text_entries {
                    if item.language.name == "en" && !pokemon.description.contains(item.flavor_text.replacingOccurrences(of: "\n", with: " ")) {

                        pokemon.description += "\(item.flavor_text.replacingOccurrences(of: "\n", with: " "))\n"
                    }
                }
            }
        } catch {
            print(error.self)
        }
    }
}
