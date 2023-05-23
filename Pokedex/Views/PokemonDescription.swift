//
//  PokemonDescription.swift
//  Pokedex
//
//  Created by Kevin on 5/23/23.
//

import SwiftUI

struct PokemonDescription: View {
    private var description: String
    private var name: String
    
    init(description: String, name: String) {
        self.description = description
        self.name = name
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name.capitalized)
                .font(.headline)
            ScrollView {
                Text(description)
                    .font(.body)
            }
        }
        .padding()
    }
}

struct PokemonDescription_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDescription(description: "Test string", name: "Test Name")
    }
}
