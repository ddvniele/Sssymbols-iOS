//
//  AllSymbolsView.swift
//  Sssymbols-iOS
//
//  Created by dan on 06/09/24.
//

import SwiftUI

struct AllSymbolsView: View {
    
    // search
    @Binding var searchText: String
    
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
    @State var addedToFavorites: String = ""
    @State var removedFromFavorites: String = ""
    
    // body
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                ForEach(searchText == "" ? SFSymbols.shared.allSymbols6 : SFSymbols.shared.searchedSymbols, id: \.self) { symbol in
                    ZStack {
                        Circle()
                        .foregroundStyle(.tertiary)
                        .opacity(0.2)
                        .frame(width: 60, height: 60)
                        
                        if clipboardText == symbol {
                            Text("Copied!")
                            .font(.system(size: 10))
                        } else if addedToFavorites == symbol {
                            Text("Added!")
                            .font(.system(size: 10))
                        } else if removedFromFavorites == symbol {
                            Text("Removed!")
                            .font(.system(size: 8))
                        } else {
                            Image(systemName: symbol)
                            .font(.system(size: 20))
                        } // IF ELSE
                    } // ZSTACK
                    .contentShape(ContentShapeKinds.contextMenuPreview, Circle())
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
                            
                            if SFSymbols.shared.favoritesSymbols.contains(symbol) {
                                Button(action: {
                                    if let index = SFSymbols.shared.favoritesSymbols.firstIndex(of: symbol) {
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
                            } else {
                                Button(action: {
                                    SFSymbols.shared.addToFavorites(symbol: symbol)
                                    withAnimation {
                                        addedToFavorites = symbol
                                        let seconds = 3.0
                                        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                                            if addedToFavorites == symbol {
                                                withAnimation {
                                                    addedToFavorites = ""
                                                } // WITH ANIMATION
                                            } // IF
                                        } // DISPATCH QUEUE
                                    } // WITH ANIMATION
                                }, label: {
                                    Label("Add to Favorites", systemImage: "star.fill")
                                }) // BUTTON + label
                            } // IF ELSE
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
            .animation(.easeInOut(duration: 0.15), value: searchText)
            .animation(.easeInOut(duration: 0.15), value: SFSymbols.shared.selectedAllSymbols)
            .animation(.easeInOut(duration: 0.15), value: SFSymbols.shared.searchedSymbols)
        } // SCROLL VIEW
        .overlay(
            ZStack {
                if searchText != "" && SFSymbols.shared.searchedSymbols.isEmpty {
                    ContentUnavailableView.search(text: searchText)
                    .animation(.easeInOut(duration: 0.15), value: searchText)
                    .animation(.easeInOut(duration: 0.15), value: SFSymbols.shared.searchedSymbols)
                } // IF
            } // ZSTACK
        ) // OVERLAY
    } // VAR BODY
} // STRUCT ALL SYMBOLS VIEW

#Preview {
    AllSymbolsView(searchText: MainView().$searchText)
} // PREVIEW
