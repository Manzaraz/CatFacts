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
            ZStack {
                List(catVM.breeds) { catBreed in
                    LazyVStack(alignment: .leading) {
                        NavigationLink {
                            DetailView(catBreed: catBreed)
                        } label: {
                            Text(catBreed.breed)
                                .font(.title2)
                        }
                    }
                    .task {
                        await catVM.loadNextIfNeeded(catBreed: catBreed)
                    }
                    
                }
                .listStyle(.plain)
                .navigationTitle("Cat Breeds:")
                .toolbar {
                    ToolbarItem(placement: .status) {
                        Text("\(catVM.breeds.count) of \(catVM.total) breeds.")
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        Button("Load All") {
                            Task {
                                await catVM.loadAll()
                            }
                        }
                    }
                }
                
                if catVM.isLoading {
                    ProgressView()
                        .scaleEffect(4)
                        .tint(.red)
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
