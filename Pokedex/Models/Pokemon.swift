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
    var types: [String]
    var baseHappiness: Int
    var captureRate: Int
    var isLegendary: Bool
    var isMythical: Bool
    var baseExperience: Int
    var height: Int
    var moves: [String]
}

struct ListResponse: Codable {
    var results: [ListResult]
}

struct ListResult: Codable {
    var name: String
    var url: String
}


//Retrieving data from https://pokeapi.co/api/v2/pokemon/{name or id}
struct PokemonResponse: Codable {
    var sprites: Sprites
    var base_experience: Int
    var height: Int
    var moves: [MoveData]
    var id: Int
}

struct MoveData: Codable {
    var move: Move
}

struct Move: Codable {
    var name: String
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


//Retrieving data from https://pokeapi.co/api/v2/pokemon-species/{name or id}
struct PokemonInfoResponse: Codable {
    var base_happiness: Int
    var capture_rate: Int
    var flavor_text_entries: [FlavorTextEntry]
    var is_legendary: Bool
    var is_mythical: Bool
}

struct FlavorTextEntry: Codable {
    var flavor_text: String
    var language: PokemonLanguage
}

struct PokemonLanguage: Codable {
    var name: String
    var url: String
}



//For retrieving Pokemon types from https://pokeapi.co/api/v2/pokemon-form/{name or id}
struct PokemonFormResponse: Codable {
    var types: [Types]
}

struct Types: Codable {
    var type: TypeData
}

struct TypeData: Codable {
    var name: String
}



