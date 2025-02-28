//
//  FactViewModel.swift
//  CatFacts
//
//  Created by Christian Manzaraz on 28/02/2025.
//

import Foundation

@Observable
class FactViewModel {
    struct Returned: Codable {
        var fact: String
    }
    
    
    var fact = ""
    var urlString = "https://catfact.ninja/fact"
    var isLoading = false
    
    func getData() async {
        isLoading = true
        print("🕸️Accesing to the Web. url: \(urlString)")
        
        // Create URL
        guard let url = URL(string: urlString) else {
            print("😡URL ERROR: We couldn't convert the string to a valid URL, chefck the urlString.")
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Try to decode JSON data into our own data structures
            guard let returned = try?JSONDecoder().decode(Returned.self, from: data) else {
                print("😡JSON ERROR: Could not decode returned JSON data.")
                isLoading = false
                return
            }
            
            Task {@MainActor in
                fact = returned.fact
                isLoading = false
            }
            print("😎 Fact returned! \(fact)")
        } catch {
            print("😡SOMETHING WENT WRONG: Could not get data from urlString\n\(error.localizedDescription).")
            isLoading = false
        }
    }
    
}
