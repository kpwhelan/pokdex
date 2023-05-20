//
//  Pokemon.swift
//  Pokedex
//
//  Created by Kevin on 5/18/23.
//

import Foundation

struct Pokemon {
    var id = UUID()
    var name: String
    var imageUrl: String
    var description: String
}

class globalPokemonList: ObservableObject {
    @Published var pokemonList = [Pokemon]()
}

struct ListResponse: Codable {
    var results: [ListResult]
}

struct ListResult: Codable {
    var name: String
    var url: String
}

struct PokemonResponse: Codable {
    var sprites: Sprites
}

struct Sprites: Codable {
    var other: ArtWorkType
}

struct ArtWorkType: Codable {
    var home: PokemonImage
}

struct PokemonImage: Codable {
    var front_default: String
}

struct PokemonInfoResponse: Codable {
    var base_happiness: Int
    var capture_rate: Int
    var flavor_text_entries: [FlavorTextEntry]
}

struct FlavorTextEntry: Codable {
    var flavor_text: String
    var language: PokemonLanguage
}

struct PokemonLanguage: Codable {
    var name: String
    var url: String
}
