//
//  RowView.swift
//  Pokedex
//
//  Created by Kevin on 5/24/23.
//

import SwiftUI

struct RowDataView: View {
    private var rowName: String
    private var data: String
    
    init(rowName: String, data: String) {
        self.rowName = rowName
        self.data    = data
    }
    var body: some View {
        HStack {
            Text(rowName)
                .fontWeight(.bold)
            Text(data)
        }
        Spacer()
    }
}

