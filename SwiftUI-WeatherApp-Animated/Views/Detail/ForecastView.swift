//
//  ForecastView.swift
//  SwiftUI-WeatherApp-Animated
//
//  Created by Bekzhan Talgat on 01.07.2023.
//

import SwiftUI

struct ForecastView: View {
    var bottomSheetTranslationProrated: CGFloat = 1
    @State var selection: Int = 0
    
    var body: some View {
        ScrollView {
            // MARK: segmented control
            VStack(spacing: 0) {
                SegmentedControl(selection: $selection)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(selection == 0 ? Forecast.hourly : Forecast.weekly) { forecast in
                            ForecastCard(forecast: forecast, period: selection == 0 ? .hourly : .daily)
                        }
                        .transition(.offset(x: selection == 0 ? -430 : 430))
                    }
                    .padding(.vertical, 20)
                }
                .padding(.horizontal, 20)
                
                Image("Forecast Widgets")
                    .opacity(bottomSheetTranslationProrated)
            }
        }
        .backgroundBlur(radius: 25, opaque: true)
        .background(Color.bottomSheetBackground)
        .clipShape(RoundedRectangle(cornerRadius: 44))
        .innerShadow(
            shape: RoundedRectangle(cornerRadius: 44),
            color: Color.bottomSheetBorderMiddle,
            lineWidth: 1,
            offsetY: 1,
            blurRadius: 0,
            blendMode: .overlay,
            opacity: 1 - bottomSheetTranslationProrated
        )
        .overlay {
            // MARK: Bottom sheet separator
            Divider()
                .blendMode(.overlay)
                .background(Color.bottomSheetBorderTop)
                .frame(maxHeight: .infinity, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 44))
        }
        .overlay {
            // MARK: Drag indecator
            RoundedRectangle(cornerRadius: 10)
                .fill(.black).opacity(0.3)
                .frame(width: 48, height: 5)
                .frame(height: 20)
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
            .background(Color.background)
            .preferredColorScheme(.dark)
    }
}
