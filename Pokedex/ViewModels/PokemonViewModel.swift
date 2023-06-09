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
    
    private let spritesUrl        = "https://pokeapi.co/api/v2/pokemon/"
    private let speciesUrl        = "https://pokeapi.co/api/v2/pokemon-species/"
    private let pokemonFormUrl    = "https://pokeapi.co/api/v2/pokemon-form/"
    private let evolutionChainUrl = "https://pokeapi.co/api/v2/evolution-chain/"
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    func getPokemonData() async {
        await getPokemonImageUrl()
        await getPokemonDescription()
        await getPokemonTypes()
    }
    
    func getPokemonImageUrl() async {
        guard let url = URL(string: "\(spritesUrl)\(pokemon.name)") else {
            print("No Pokemon URL provided")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(PokemonResponse.self, from: data) {
                pokemon.imageUrl       = decodedResponse.sprites.other.home.front_default
                pokemon.baseExperience = decodedResponse.base_experience
                pokemon.height         = decodedResponse.height
                
                for move in decodedResponse.moves {
                    pokemon.moves.append(move.move.name.capitalized)
                }

            }
        } catch {
            print(error.self)
        }
    }
    
    func getPokemonDescription() async {
        guard let url = URL(string: "\(speciesUrl)\(pokemon.name)") else {
            print("No URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(PokemonInfoResponse.self, from: data) {
                pokemon.baseHappiness = decodedResponse.base_happiness
                pokemon.captureRate   = decodedResponse.capture_rate
                pokemon.isMythical    = decodedResponse.is_mythical
                pokemon.isLegendary   = decodedResponse.is_legendary
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
    
    func getPokemonTypes() async {
        guard let url = URL(string: "\(pokemonFormUrl)\(pokemon.name)") else {
            print("No URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(PokemonFormResponse.self, from: data) {
                for type in decodedResponse.types {
                    pokemon.types.append(type.type.name.capitalized)
                }
            }
        } catch {
            print(error.self)
        }
    }
}
