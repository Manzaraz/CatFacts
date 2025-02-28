//
//  DetailView.swift
//  CatFacts
//
//  Created by Christian Manzaraz on 27/02/2025.
//

import SwiftUI

struct DetailView: View {
    @State var catBreed: CatBreed
    var body: some View {
        List {
            HStack {
                Text("Country:")
                    .bold()
                Spacer()
                Text("Country: \(catBreed.country)")
                    .foregroundStyle(.secondary)
            }
            HStack {
                Text("Origin:")
                    .bold()
                Spacer()
                Text(catBreed.origin)
                    .foregroundStyle(.secondary)
            }
            HStack {
                Text("Coat:")
                    .bold()
                Spacer()
                Text(catBreed.coat)
                    .foregroundStyle(.secondary)
            }
            HStack {
                Text("Pattern:")
                    .bold()
                Spacer()
                Text(catBreed.pattern)
                    .foregroundStyle(.secondary)
            }
            
            
        }
        .listStyle(.plain)
        .navigationTitle(catBreed.breed)
    }
}

#Preview {
    NavigationStack {
        DetailView(
            catBreed: CatBreed(
                breed: "Burmese",
                country: "Burma & Thailand",
                origin: "Natural",
                coat: "Short",
                pattern: "Solid"
            )
        )
    }
}
