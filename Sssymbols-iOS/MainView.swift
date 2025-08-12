//
//  MainView.swift
//  Sssymbols-iOS
//
//  Created by dan on 06/09/24.
//

import SwiftUI

struct MainView: View {
    
    // selected tab
    @State var selectedTab: Int = 1
    
    // search
    @State var searchText: String = ""
    @State var searchFavoritesText: String = ""
    
    // body
    var body: some View {
        TabView(selection: $selectedTab) {
            NavView(view: {
                AllSymbolsView(searchText: $searchText)
            }, selectedTab: $selectedTab, searchText: $searchText, searchFavoritesText: $searchFavoritesText)
            .tabItem {
                Label("All", systemImage: "tray.full")
                .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
            } // TAB ITEM
            .tag(1)
            
            NavView(view: {
                FavoritesView(searchFavoritesText: $searchFavoritesText)
            }, selectedTab: $selectedTab, searchText: $searchText, searchFavoritesText: $searchFavoritesText)
            .tabItem {
                Label("Favorites", systemImage: "star")
                .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
            } // TAB ITEM
            .tag(2)
            
            NavView(view: {
                InfoView()
            }, selectedTab: $selectedTab, searchText: $searchText, searchFavoritesText: $searchFavoritesText)
            .tabItem {
                Label("Info", systemImage: "info.circle")
                .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
            } // TAB ITEM
            .tag(3)
        } // TAB VIEW
        .onChange(of: searchText) {
            SFSymbols.shared.searchedSymbols = SFSymbols.shared.allSymbols6.filter { $0.self.localizedCaseInsensitiveContains(searchText) }
        } // ON CHANGE
        .onChange(of: searchFavoritesText) {
            SFSymbols.shared.searchedFavoritesSymbols = SFSymbols.shared.favoritesSymbols6.filter { $0.self.localizedCaseInsensitiveContains(searchFavoritesText) }
        } // ON CHANGE
    } // VAR BODY
} // STRUCT MAIN VIEW

#Preview {
    MainView()
} // PREVIEW
