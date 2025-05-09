//
//  Arbetsprov.swift
//  Arbetsprov
//
//  Created by Sebastian Strus on 2025-05-09.
//

//
//  Arbetsprov.swift
//  Arbetsprov
//

import SwiftUI

@main
struct Arbetsprov: App {
    let store = RatingStore()
    
    var body: some Scene {
        WindowGroup {
            MainView(store: store)
        }
    }
}




