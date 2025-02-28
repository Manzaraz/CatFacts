//
//  CatViewModel.swift
//  CatFacts
//
//  Created by Christian Manzaraz on 27/02/2025.
//

import Foundation

@Observable
class CatViewModel {
    
    struct Returned: Codable {
        var data: [CatBreed]
        var total: Int
        var next_page_url: String? // might return null
    }
    
    var breeds = [CatBreed]()
    var total = 0
    
    var urlString = "https://catfact.ninja/breeds"
    
    
    func getData() async {
        print("🕸️Accesing to the Web. url: \(urlString)")
        
        // Create URL
        guard let url = URL(string: urlString) else {
            print("😡URL ERROR: We couldn't convert the string to a valid URL, chefck the urlString.")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Try to decode JSON data into our own data structures
            guard let returned = try?JSONDecoder().decode(Returned.self, from: data) else {
                print("😡JSON ERROR: Could not decode returned JSON data.")
                return
            }
            
            Task {@MainActor in
                urlString = returned.next_page_url ?? ""
                breeds += returned.data // Make sure you add nuew page to existing page of breeds
                total = returned.total
            }
            print("😎 Breeds returned! Total #: \(breeds.count)")
        } catch {
            print("😡SOMETHING WENT WRONG: Could not get data from urlString\n\(error.localizedDescription).")
        }
    }
    
    
    func loadNextIfNeeded(catBreed: CatBreed) async {
        guard let lastBred = breeds.last else { return } //Find last breed that has been loaded to our array
        // Check if teh CatBreed passed in is the last breed loaded, if so, load another page if you can
        if catBreed.id == lastBred.id && urlString != "" {
            Task {
                await getData()
            }
//        } else {
            
        }
    }
}
