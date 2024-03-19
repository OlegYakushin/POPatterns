//
//  MainView.swift
//  POPatterns
//
//  Created by Oleg Yakushin on 3/19/24.
//

import SwiftUI

struct MainView: View {
    @State private var selected = "Patterns"
    @State private var favoritePatterns: [String] = []
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0.40, blue: 1).opacity(0), Color(red: 0, green: 0.76, blue: 1)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack{
                    HStack{
                        Text("Patterns")
                            .textCase(.uppercase)
                            .font(.custom("Inter-Bold", size: 32))
                            .foregroundColor(self.selected == "Patterns" ? Color.black : Color.gray)
                            .onTapGesture {
                                selected = "Patterns"
                            }
                        Text("Favorites")
                            .textCase(.uppercase)
                            .font(.custom("Inter-Bold", size: 32))
                            .foregroundColor(selected == "Favorites" ? Color.black : Color.gray)
                            .onTapGesture {
                                selected = "Favorites"
                                loadFavorites()
                            }
                    }
                    NavigationLink(destination: NPLAssistantView().navigationBarBackButtonHidden()){
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 344, height: 60)
                            .foregroundColor(.white)
                            .overlay(
                                HStack{
                                    Text("PNL ASSISTANT")
                                        .foregroundColor(.black)
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.black)
                                }
                            )
                    }
                    ScrollView(showsIndicators: false){
                        VStack(spacing: 20){
                            ForEach(filteredPatterns, id: \.name) { pattern in
                                NavigationLink(destination: PatternDetailView(patternName: pattern.name, patternDescription: pattern.description).navigationBarBackButtonHidden()) {
                                    EachPatternView(patternName: pattern.name)
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
                    loadFavorites()
                }
    }
    private var filteredPatterns: [PatternModel] {
          if selected == "Favorites" {
              return PatternModel.patternData.filter { favoritePatterns.contains($0.name) }
          } else {
              return PatternModel.patternData
          }
      }
      
      private func loadFavorites() {
          if let savedPatterns = UserDefaults.standard.array(forKey: "favoritePatterns") as? [String] {
              favoritePatterns = savedPatterns
            print(savedPatterns)
          }
      }
}

#Preview {
    MainView()
}
