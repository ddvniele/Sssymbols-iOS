//
//  NavView.swift
//  Sssymbols-iOS
//
//  Created by dan on 06/09/24.
//

import SwiftUI
import PhotosUI

struct NavView<Content: View>: View {
    
    // view
    @ViewBuilder var view: Content
    
    // binding selected tab
    @Binding var selectedTab: Int
    
    // search
    @Binding var searchText: String
    @Binding var searchFavoritesText: String
    
    // body
    var body: some View {
        if selectedTab != 3 {
            NavigationStack {
                view
                .navigationTitle("Sssymbols!")
                .searchable(text: selectedTab == 1 ? $searchText : $searchFavoritesText, placement: .navigationBarDrawer(displayMode: .always))
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("by @ddvniele")
                        .font(.system(size: 15))
                        .foregroundStyle(.secondary)
                    } // TOOL BAR ITEM
                } // TOOL BAR
            } // NAVIGATION STACK
        } else {
            NavigationStack {
                view
                .navigationTitle("Sssymbols!")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("by @ddvniele")
                        .font(.system(size: 15))
                        .foregroundStyle(.secondary)
                    } // TOOL BAR ITEM
                } // TOOL BAR
            } // NAVIGATION STACK
        } // IF ELSE
    } // VAR BODY
} // STRUCT NAV VIEW
