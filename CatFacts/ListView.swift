//
//  ListView.swift
//  CatFacts
//
//  Created by Christian Manzaraz on 27/02/2025.
//

import SwiftUI

struct ListView: View {
    
    @State private var catVM = CatViewModel()
    var body: some View {
        NavigationStack {
            List(catVM.breeds) { breed in
                Text(breed.breed)
                    .font(.title2)
            }
            .listStyle(.plain)
            .navigationTitle("Cat Breeds")
        }
        .task {
            await catVM.getData()
        }
    }
}

#Preview {
    ListView()
}
