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
    @Binding var selectedTab: SFSymbols.Tabs
    
    // search
    @Binding var searchText: String
    @Binding var searchFavoritesText: String
    
    // favorites
    @State var deleteAllFavoritesIsPresented: Bool = false
    
    // body
    var body: some View {
        if #available(iOS 26, *) {
            NavigationStack {
                view
                .navigationTitle("Sssymbols!")
                .navigationSubtitle("by @ddvniele")
                .background(
                    SearchHost(text: selectedTab == .all ? $searchText : $searchFavoritesText, disabled: selectedTab == .info, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search...")
                )
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu(content: {
                            if selectedTab == .favorites {
                                Menu(content: {
                                    Button(role: .destructive, action: {
                                        SFSymbols.shared.favoritesSymbols.removeAll()
                                        UserDefaults.standard.set(SFSymbols.shared.favoritesSymbols, forKey: "FAVORITES_SYMBOLS")
                                    }, label: {
                                        Label("Confirm", systemImage: "exclamationmark.circle")
                                    }) // BUTTON + label
                                }, label: {
                                    Label("Delete all Favorites", systemImage: "trash")
                                }) // MENU + label
                                .disabled(SFSymbols.shared.favoritesSymbols.isEmpty)
                                
                                Divider()
                            } // IF
                            
                            Menu(content: {
                                Section(content: {
                                    ForEach(SFSymbols.shared.possibleSymbols, id: \.name) { symbols in
                                        Button(action: {
                                            SFSymbols.shared.selectedSymbols = symbols.name
                                            UserDefaults.standard.set(SFSymbols.shared.selectedSymbols, forKey: "SELECTED_SYMBOLS")
                                        }, label: {
                                            Text(symbols.name)
                                            if (SFSymbols.shared.selectedSymbols == symbols.name) {
                                                Image(systemName: "checkmark")
                                            } // IF
                                        }) // BUTTON + label
                                        .disabled(!ProcessInfo.processInfo.isOperatingSystemAtLeast(symbols.version))
                                    } // FOR EACH
                                }, header: {
                                    Text("If you see gray options, update your iOS version")
                                }) // SECTION + header
                            }, label: {
                                Label("Choose SF Symbols", systemImage: "seal")
                            }) // MENU + label
                            .onChange(of: SFSymbols.shared.selectedSymbols) {
                                SFSymbols.shared.updateSelectedAllSymbols()
                            } // ON CHANGE
                            
                            Divider()
                            
                            Section(content: {
                                Link(destination: URL(string: "https://github.com/ddvniele/Sssymbols-iOS/releases/latest")!, label: {
                                    Label("Check for updates...", systemImage: "arrow.counterclockwise")
                                }) // LINK + label
                                .keyboardShortcut("u")
                            }, header: {
                                Text("Sssymbols! iOS v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown")")
                            }) // SECTION + header
                        }, label: {
                            Label("Tools", systemImage: "ellipsis.circle")
                        }) // MENU + label
                    } // TOOL BAR ITEM
                } // TOOL BAR
            } // NAVIGATION STACK
        } else {
            NavigationStack {
                view
                .navigationTitle("Sssymbols!")
                .background(
                    SearchHost(text: selectedTab == .all ? $searchText : $searchFavoritesText, disabled: selectedTab == .info, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search...")
                )
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("by @ddvniele")
                        .font(.system(size: 15))
                        .foregroundStyle(.secondary)
                    } // TOOL BAR ITEM
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu(content: {
                            if selectedTab == .favorites {
                                Menu(content: {
                                    Button(role: .destructive, action: {
                                        SFSymbols.shared.favoritesSymbols.removeAll()
                                        UserDefaults.standard.set(SFSymbols.shared.favoritesSymbols, forKey: "FAVORITES_SYMBOLS")
                                    }, label: {
                                        Label("Confirm", systemImage: "exclamationmark.circle")
                                    }) // BUTTON + label
                                }, label: {
                                    Label("Delete all Favorites", systemImage: "trash")
                                }) // MENU + label
                                .disabled(SFSymbols.shared.favoritesSymbols.isEmpty)
                                
                                Divider()
                            } // IF
                            
                            Menu(content: {
                                Section(content: {
                                    ForEach(SFSymbols.shared.possibleSymbols, id: \.name) { symbols in
                                        Button(action: {
                                            SFSymbols.shared.selectedSymbols = symbols.name
                                            UserDefaults.standard.set(SFSymbols.shared.selectedSymbols, forKey: "SELECTED_SYMBOLS")
                                        }, label: {
                                            Text(symbols.name)
                                            if (SFSymbols.shared.selectedSymbols == symbols.name) {
                                                Image(systemName: "checkmark")
                                            } // IF
                                        }) // BUTTON + label
                                        .disabled(!ProcessInfo.processInfo.isOperatingSystemAtLeast(symbols.version))
                                    } // FOR EACH
                                }, header: {
                                    Text("If you see gray options, update your iOS version")
                                }) // SECTION + header
                            }, label: {
                                Label("Choose SF Symbols", systemImage: "seal")
                            }) // MENU + label
                            .onChange(of: SFSymbols.shared.selectedSymbols) {
                                SFSymbols.shared.updateSelectedAllSymbols()
                            } // ON CHANGE
                            
                            Divider()
                            
                            Section(content: {
                                Link(destination: URL(string: "https://github.com/ddvniele/Sssymbols-iOS/releases/latest")!, label: {
                                    Label("Check for updates...", systemImage: "arrow.counterclockwise")
                                }) // LINK + label
                                .keyboardShortcut("u")
                            }, header: {
                                Text("Sssymbols! iOS v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown")")
                            }) // SECTION + header
                        }, label: {
                            Label("Tools", systemImage: "ellipsis.circle")
                        }) // MENU + label
                    } // TOOL BAR ITEM
                } // TOOL BAR
            } // NAVIGATION STACK
        } // IF ELSE
    } // VAR BODY
} // STRUCT NAV VIEW

struct SearchHost: View {
    @Binding var text: String
    let disabled: Bool
    let placement: SearchFieldPlacement
    let prompt: LocalizedStringKey

    private var readOnlyText: Binding<String> {
        Binding(
            get: { text },
            set: { _ in } // ignora input se disabilitata
        )
    }

    var body: some View {
        Color.clear
            .frame(width: 0, height: 0)
            .searchable(
                text: disabled ? readOnlyText : $text,
                placement: placement,
                prompt: prompt
            )
            .disabled(disabled)
    }
}

#Preview {
    MainView()
} // PREVIEW
