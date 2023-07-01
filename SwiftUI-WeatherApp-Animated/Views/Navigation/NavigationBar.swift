//
//  NavigationBar.swift
//  SwiftUI-WeatherApp-Animated
//
//  Created by Bekzhan Talgat on 01.07.2023.
//

import SwiftUI

struct NavigationBar: View {
    @Environment(\.dismiss) var dismiss
    @Binding var searchText: String
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 23, weight: .medium))
                            .foregroundColor(.secondary)
                        
                        Text("Weather")
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                    .frame(height: 44)
                }
                
                Spacer()
                
                Image(systemName: "ellipsis.circle")
                    .font(.system(size: 28))
                    .frame(width: 44, height: 44, alignment: .trailing)

            }
            .frame(height: 52)
            
            // MARK: Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("Search for acity or airpoty", text: $searchText)
            }
            .foregroundColor(.secondary)
            .padding(.horizontal, 6)
            .padding(.vertical, 7)
            .frame(height: 36, alignment: .leading)
            .background(
                Color.bottomSheetBackground,
                in: RoundedRectangle(cornerRadius: 10)
            )
            .innerShadow(
                shape: RoundedRectangle(cornerRadius: 10),
                color: .black.opacity(0.25),
                lineWidth: 2,
                offsetX: 0, offsetY: 2,
                blurRadius: 2
            )
        }
        .frame(height: 106, alignment: .top)
        .padding(.horizontal, 16)
        .padding(.top, 49)
        .backgroundBlur(radius: 20, opaque: true)
        .background(Color.navBarBackground)
        .frame(maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea()
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(searchText: .constant(""))
            .preferredColorScheme(.dark)
    }
}
