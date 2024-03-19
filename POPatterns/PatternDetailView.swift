//
//  PatternDetailView.swift
//  POPatterns
//
//  Created by Oleg Yakushin on 3/19/24.
//

import SwiftUI

struct PatternDetailView: View {
    @State private var isFavorite = false
    @State private var favoritePatterns: [String] = []
    @Environment(\.presentationMode) var presentationMode
    var patternName: String
    var patternDescription: String = "Head and shoulders"
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0.40, blue: 1).opacity(0), Color(red: 0, green: 0.76, blue: 1)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                Text(patternName)
                    .textCase(.uppercase)
                    .font(.custom("Inter-Bold", size: 30))
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 342, height: 201)
                    .foregroundColor(.white)
                    .overlay(
                Image(patternName)
                    .resizable()
                    .frame(width: 342, height: 201)
                )
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 342, height: 346)
                    .foregroundColor(.white)
                    .overlay(
                        ScrollView(showsIndicators: false){
                            Text(patternDescription)
                                .font(.custom("Inter-Regular", size: 15))
                                .padding()
                        }
                    )
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 344, height: 63)
                    .foregroundColor(.white)
                    .overlay(
                                           Button(action: {
                                               toggleFavorite()
                                           }) {
                                               Text(isFavorite ? "REMOVE FROM FAVORITES" : "ADD TO FAVORITES")
                                                   .font(.custom("Inter-Regular", size: 15))
                                                   .foregroundColor(Color("bluePattern"))
                                           }
                                       )
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 344, height: 63)
                    .foregroundColor(.white)
                    .overlay(
                        Text("BACK TO LIST")
                            .font(.custom("Inter-Regular", size: 15))
                            .foregroundColor(Color("bluePattern"))
                    )
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                
                
            }
        }
        .onAppear {
                    loadFavoriteStatus()
                }
    }
    
    private func loadFavoriteStatus() {
           let favoritePatterns = UserDefaults.standard.stringArray(forKey: "favoritePatterns") ?? []
           isFavorite = favoritePatterns.contains(patternName)
       }
    
    private func toggleFavorite() {
           if isFavorite {
               removeFromFavorites()
           } else {
               addToFavorites()
           }
       }
       
    private func addToFavorites() {
        var favoritePatterns = UserDefaults.standard.stringArray(forKey: "favoritePatterns") ?? []
        if !favoritePatterns.contains(patternName) {
            favoritePatterns.append(patternName)
            UserDefaults.standard.set(favoritePatterns, forKey: "favoritePatterns")
            isFavorite = true
        }
    }

       private func removeFromFavorites() {
           var favoritePatterns = UserDefaults.standard.stringArray(forKey: "favoritePatterns") ?? []
           favoritePatterns.removeAll { $0 == patternName }
           UserDefaults.standard.set(favoritePatterns, forKey: "favoritePatterns")
           isFavorite = false
       
    }
}

#Preview {
    PatternDetailView(patternName:"Head and shoulders", patternDescription: "Head and shoulders is a chart pattern in which a large peak has a slightly smaller peak on either side of it. Traders look at head and shoulders patterns to predict a bullish-to-bearish reversal. Typically, the first and third peak will be smaller than the second, but they will all fall back to the same level of support, otherwise known as the ‘neckline’. Once the third peak has fallen back to the level of support, it is likely that it will breakout into a bearish downtrend.")
}
