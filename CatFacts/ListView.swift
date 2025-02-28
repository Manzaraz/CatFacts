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
            List(catVM.breeds) { catBreed in
                NavigationLink {
                    DetailView(catBreed: catBreed)
                } label: {
                    Text(catBreed.breed)
                        .font(.title2)
                }

            }
            .listStyle(.plain)
            .navigationTitle("Cat Breeds:")
            .toolbar {
                ToolbarItem(placement: .status) {
                    Text("\(catVM.breeds.count) of \(catVM.total) breeds.")
                }
            }
        }
        .task {
            await catVM.getData()
        }
    }
}

#Preview {
    ListView()
}
