//
//  MainView.swift
//  Sssymbols-iOS
//
//  Created by dan on 06/09/24.
//

import SwiftUI

struct MainView: View {
    
    // selected tab
    @State var selectedTab: SFSymbols.Tabs = .all
    
    // search
    @State var searchText: String = ""
    @State var searchFavoritesText: String = ""
    
    // body
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(value: .all) {
                NavView(view: {
                    AllSymbolsView(searchText: $searchText)
                }, selectedTab: $selectedTab, searchText: $searchText, searchFavoritesText: $searchFavoritesText)
            } label: {
                Label("All", systemImage: "seal")
                .environment(\.symbolVariants, selectedTab == .all ? .fill : .none)
            } // TAB + label
            
            Tab(value: .favorites) {
                NavView(view: {
                    FavoritesView(searchFavoritesText: $searchFavoritesText)
                }, selectedTab: $selectedTab, searchText: $searchText, searchFavoritesText: $searchFavoritesText)
            } label: {
                Label("Favorites", systemImage: "star")
                .environment(\.symbolVariants, selectedTab == .favorites ? .fill : .none)
            } // TAB + label
            
            Tab(value: .info) {
                NavView(view: {
                    InfoView()
                }, selectedTab: $selectedTab, searchText: $searchText, searchFavoritesText: $searchFavoritesText)
            } label: {
                Label("Info", systemImage: "info.circle")
                .environment(\.symbolVariants, selectedTab == .info ? .fill : .none)
            } // TAB + label
        } // TAB VIEW
        .onChange(of: searchText) {
            SFSymbols.shared.searchedSymbols = SFSymbols.shared.allSymbols6.filter { $0.self.localizedCaseInsensitiveContains(searchText) }
        } // ON CHANGE
        .onChange(of: searchFavoritesText) {
            SFSymbols.shared.searchedFavoritesSymbols = SFSymbols.shared.favoritesSymbols.filter { $0.self.localizedCaseInsensitiveContains(searchFavoritesText) }
        } // ON CHANGE
    } // VAR BODY
} // STRUCT MAIN VIEW

#Preview {
    MainView()
} // PREVIEW
