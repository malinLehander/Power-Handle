//
//  ContentView.swift
//  project2021
//
//  Created by Malin Lehander on 2021-12-20.
//

import SwiftUI

struct ContentView: View {
    
    var viewModel = MeasurementViewModel()
    var body: some View {
        TabView {
            HomeView().tabItem{
                Image(systemName:"house")
                Text("Home")
            }
            HistoryView().tabItem{
                Image(systemName: "list.bullet")
                Text("History")
            }
            SettingsView().tabItem{
                Image(systemName: "gear")
                Text("Settings")
            }
        }
        .environmentObject(viewModel)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
