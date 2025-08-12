//
//  InfoView.swift
//  Sssymbols-iOS
//
//  Created by dan on 06/09/24.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Image("Icon")
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 90)
                VStack(alignment: .leading) {
                    Text("Sssymbols!")
                    .font(.system(size: 25, weight: .medium, design: .rounded))
                    .padding(.top, 10)
                    Text("open source with ❤️")
                    .font(.system(size: 12.5))
                    .foregroundStyle(.gray)
                    Link("Project on GitHub", destination: URL(string: "https://github.com/ddvniele/Sssymbols-iOS")!)
                    .buttonStyle(.bordered)
                } // VSTACK
                .padding(.leading, 20)
            } // VSTACK
            .padding(.leading, 35)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Rectangle()
            .foregroundStyle(.quaternary)
            .frame(height: 1)
            
            Spacer()
            
            HStack {
                Image("ddvniele")
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 90)
                VStack(alignment: .leading) {
                    Text("Dan ツ")
                    .font(.system(size: 25, weight: .medium, design: .rounded))
                    .padding(.top, 10)
                    Text("@ddvniele")
                    .font(.system(size: 12.5))
                    .foregroundStyle(.gray)
                    Link("@ddvniele on GitHub", destination: URL(string: "https://github.com/ddvniele")!)
                    .buttonStyle(.bordered)
                } // VSTACK
                .padding(.leading, 20)
            } // VSTACK
            .padding(.leading, 35)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Rectangle()
            .foregroundStyle(.quaternary)
            .frame(height: 1)
            
            Spacer()
            
            HStack {
                Image("macOS")
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 90)
                VStack(alignment: .leading) {
                    Text("macOS app")
                    .font(.system(size: 25, weight: .medium, design: .rounded))
                    .padding(.top, 10)
                    Text("Download the macOS version ↓")
                    .font(.system(size: 12.5))
                    .foregroundStyle(.gray)
                    Link("Download for macOS", destination: URL(string: "https://github.com/ddvniele/Sssymbols-macOS")!)
                    .buttonStyle(.bordered)
                } // VSTACK
                .padding(.leading, 20)
            } // VSTACK
            .padding(.leading, 35)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
        } // HSTACK
    } // VAR BODY
} // STRUCT INFO VIEW

#Preview {
    InfoView()
} // PREVIEW
