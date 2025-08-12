//
//  FavoritesView.swift
//  Sssymbols-iOS
//
//  Created by dan on 06/09/24.
//

import SwiftUI

struct FavoritesView: View {
    
    // search
    @Binding var searchFavoritesText: String
    
    // lazy v grid
    let columns: [GridItem] = [
        GridItem(.fixed(35), spacing: 40),
        GridItem(.fixed(35), spacing: 40),
        GridItem(.fixed(35), spacing: 40),
        GridItem(.fixed(35), spacing: 40),
        GridItem(.fixed(35), spacing: 40),
    ] // LET COLUMNS
    
    // clipboard text
    @State var clipboardText: String = ""
    @State var removedFromFavorites: String = ""
    
    // body
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                ForEach(searchFavoritesText == "" ? SFSymbols.shared.favoritesSymbols6 : SFSymbols.shared.searchedFavoritesSymbols, id: \.self) { symbol in
                    ZStack {
                        if clipboardText == symbol {
                            Text("Copied!")
                            .font(.system(size: 10))
                        } else if removedFromFavorites == symbol {
                            Text("Removed!")
                            .font(.system(size: 8))
                        } else {
                            Image(systemName: symbol)
                            .font(.system(size: 20))
                        } // IF ELSE
                        
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .foregroundStyle(.gray)
                        .opacity(0.2)
                        .frame(width: 60, height: 60)
                    } // ZSTACK
                    .contentShape(ContentShapeKinds.contextMenuPreview, RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .contextMenu {
                        Section(symbol) {
                            Button(action: {
                                SFSymbols.shared.stringToClipboard(text: symbol)
                                withAnimation {
                                    clipboardText = symbol
                                    let seconds = 3.0
                                    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                                        if clipboardText == symbol {
                                            withAnimation {
                                                clipboardText = ""
                                            } // WITH ANIMATION
                                        } // IF
                                    } // DISPATCH QUEUE
                                } // WITH ANIMATION
                            }, label: {
                                Label("Copy symbol name", systemImage: "doc.on.clipboard")
                            }) // BUTTON + label
                            
                            Divider()
                            
                            Button(action: {
                                if let index = SFSymbols.shared.favoritesSymbols6.firstIndex(of: symbol) {
                                    SFSymbols.shared.removeFromFavorites(index: index)
                                    withAnimation {
                                        removedFromFavorites = symbol
                                        let seconds = 3.0
                                        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                                            if removedFromFavorites == symbol {
                                                withAnimation {
                                                    removedFromFavorites = ""
                                                } // WITH ANIMATION
                                            } // IF
                                        } // DISPATCH QUEUE
                                    } // WITH ANIMATION
                                } // IF LET
                            }, label: {
                                Label("Remove from Favorites", systemImage: "star.slash.fill")
                            }) // BUTTON + label
                        } // SECTION
                    } // CONTEXT MENU
                    .onTapGesture {
                        SFSymbols.shared.stringToClipboard(text: symbol)
                        withAnimation {
                            clipboardText = symbol
                            let seconds = 3.0
                            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                                if clipboardText == symbol {
                                    withAnimation {
                                        clipboardText = ""
                                    } // WITH ANIMATION
                                } // IF
                            } // DISPATCH QUEUE
                        } // WITH ANIMATION
                    } // ON TAP GESTURE
                    .sensoryFeedback(.success, trigger: clipboardText == symbol)
                } // FOR EACH
            } // LAZY V GRID
        } // SCROLL VIEW
        .overlay(
            ZStack {
                if searchFavoritesText != "" && !SFSymbols.shared.favoritesSymbols6.isEmpty && SFSymbols.shared.searchedFavoritesSymbols.isEmpty {
                    ContentUnavailableView.search(text: searchFavoritesText)
                } else if SFSymbols.shared.favoritesSymbols6.isEmpty {
                    ContentUnavailableView("No symbols added to Favorites", systemImage: "star", description: Text("To add a symbol to Favorites, right-click on it and select Add to Favorites"))
                } // IF ELSE
            } // ZSTACK
        ) // OVERLAY
    } // VAR BODY
} // STRUCT FAVORITES VIEW

#Preview {
    FavoritesView(searchFavoritesText: MainView().$searchFavoritesText)
} // PREVIEW
