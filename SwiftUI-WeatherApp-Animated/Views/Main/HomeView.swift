//
//  HomeView.swift
//  SwiftUI-WeatherApp-Animated
//
//  Created by Bekzhan Talgat on 30.06.2023.
//

import SwiftUI
import BottomSheet


enum BottomSheetPosition: CGFloat, CaseIterable {
    case top = 0.83         // 702/844
    case middle = 0.385     // 325/844
}

struct HomeView: View {
        
    @State var bottomSheetPositions: BottomSheetPosition = .middle
    @State var bottomSheetTranslation: CGFloat = BottomSheetPosition.middle.rawValue
    @State var hasDragged: Bool = false
    
    var bottomSheetTranslatedProrated: CGFloat {
        max(0.0, min((bottomSheetTranslation - BottomSheetPosition.middle.rawValue) / (BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue), 1.0))
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                let imageOffset = screenHeight + 36
                
                ZStack {
                    Color.background.edgesIgnoringSafeArea(.all)
                    
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                        .offset(y: -bottomSheetTranslatedProrated * imageOffset)
                    
                    Image("House")
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 257)
                        .offset(y: -bottomSheetTranslatedProrated * imageOffset)
                    
                    VStack(spacing: -10 * (1 - bottomSheetTranslatedProrated)) {
                        Text("Montreal")
                            .font(.largeTitle)
                        
                        VStack {
                            Text(tempAndDescription)
                            
                            Text("H:24°   L:18°")
                                .font(.title3.weight(.semibold))
                                .opacity(1 - bottomSheetTranslatedProrated)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 51)
                    .offset(y: -bottomSheetTranslatedProrated * 46)
                    
                    BottomSheetView(position: $bottomSheetPositions) {
//                        Text(bottomSheetTranslatedProrated.formatted())
                    } content: {
                        ForecastView(bottomSheetTranslationProrated: bottomSheetTranslatedProrated)
                    }
                    .onBottomSheetDrag() { translation in
                        bottomSheetTranslation = translation / screenHeight
                        
                        withAnimation(.easeInOut) {
                            hasDragged = bottomSheetPositions == BottomSheetPosition.top
                        }
                    }
                    TabBar() {
                        bottomSheetPositions = .top
                    }
                    .offset(y: bottomSheetTranslatedProrated * 115)
                }
            }
            .toolbar(.hidden)
        }
    }
    
    var tempAndDescription: AttributedString {
        let temp = "19°"
        let newLine = "\n "
        let pipe = " | "
        let description = "Mostly clear"
        
        var text = AttributedString(temp + (hasDragged ? pipe : newLine) + description)
        
        if let tempRange = text.range(of: temp) {
            text[tempRange].font = .system(
                size: (96 - (bottomSheetTranslatedProrated * (96 - 20))),
                weight: hasDragged ? .semibold : .thin
            )
            text[tempRange].foregroundColor = hasDragged ? .secondary : .primary
        }
        
        if let pipeRange = text.range(of: pipe) {
            text[pipeRange].font = .title3.weight(.semibold)
            text[pipeRange].foregroundColor = .secondary.opacity(bottomSheetTranslatedProrated)
        }
        
        if let descriptionRange = text.range(of: description) {
            text[descriptionRange].font = .title3.weight(.semibold)
            text[descriptionRange].foregroundColor = .secondary
        }
        
        return text
    }
}





struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
