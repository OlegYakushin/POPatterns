//
//  EachPatternView.swift
//  POPatterns
//
//  Created by Oleg Yakushin on 3/19/24.
//

import SwiftUI

struct EachPatternView: View {
    var patternName: String
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(width: 331, height: 146)
            .foregroundColor(.white)
            .overlay(
                HStack{
                   Text(patternName)
                        .textCase(.uppercase)
                        .font(.custom("Inter-Bold", size: 25))
                        .foregroundColor(Color("bluePattern"))
                    Spacer()
                    Image("arrow")
                }
                    .padding()
            )
    }
}

#Preview {
    EachPatternView(patternName: "Head and shoulders")
}
