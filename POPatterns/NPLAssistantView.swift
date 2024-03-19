//
//  NPLAssistantView.swift
//  POPatterns
//
//  Created by Oleg Yakushin on 3/19/24.
//

import SwiftUI

struct NPLAssistantView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var entryPrice: Int = 0
       @State private var exitPrice: Int = 0
       @State private var sharesAmount: Int = 0
       @State private var feePercentage: Int = 0
       @State private var profit: Int = 0
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0.40, blue: 1).opacity(0), Color(red: 0, green: 0.76, blue: 1)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 20){
                Text("PNL Assistant")
                    .textCase(.uppercase)
                    .font(.custom("Inter-Bold", size: 30))
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 344, height: 60)
                    .foregroundColor(.white)
                    .overlay(
                        HStack{
                            Image(systemName: "arrow.left")
                            Text("Back to patterns")
                        }
                    )
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                if profit == 0 {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 342, height: 201)
                    .foregroundColor(.white)
                    .overlay(
                        Text("PNL (Profit and Loss) is a crucial term in the context of trading and investing. It represents the net financial outcome of a trading position or investment over a certain period. You can calculate it by deducting the whole cost of purchasing an asset or investment from the total revenue you get when selling it.")
                            .font(.custom("Inter-Regular", size: 13))
                            .padding()
                    )
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 342, height: 63)
                    .foregroundColor(.white)
                    .overlay(
                        HStack{
                            Text("Entry price")
                                .foregroundColor(Color("bluePattern"))
                            TextField("", value: $entryPrice, formatter: NumberFormatter())
                                .foregroundColor(Color("bluePattern"))
                                .keyboardType(.decimalPad)
                        }
                            .padding()
                    )
                
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 342, height: 63)
                        .foregroundColor(.white)
                        .overlay(
                            HStack{
                                Text("Exit price")
                                    .foregroundColor(Color("bluePattern"))
                                TextField("", value: $exitPrice, formatter: NumberFormatter())
                                    .foregroundColor(Color("bluePattern"))
                                    .keyboardType(.decimalPad)
                            }
                                .padding()
                        )
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 342, height: 63)
                        .foregroundColor(.white)
                        .overlay(
                            HStack{
                                Text("Shares amount")
                                    .foregroundColor(Color("bluePattern"))
                                TextField("", value: $sharesAmount, formatter: NumberFormatter())
                                    .foregroundColor(Color("bluePattern"))
                                    .keyboardType(.numberPad)
                            }
                                .padding()
                        )
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 342, height: 63)
                        .foregroundColor(.white)
                        .overlay(
                            HStack{
                                Text("Percentage of fees on profit, if any")
                                    .foregroundColor(Color("bluePattern"))
                                    .frame(width: 270)
                                TextField("", value: $feePercentage, formatter: NumberFormatter())
                                    .foregroundColor(Color("bluePattern"))
                                    .keyboardType(.decimalPad)
                            }
                                .padding()
                        )
                    Spacer()
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 344, height: 63)
                        .foregroundColor(.white)
                        .overlay(
                            Button(action: calculatePNL) {
                                Text("Calculate PNL")
                                    .foregroundColor(Color("bluePattern"))
                            }
                        )
                } else{
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 342, height: 201)
                        .foregroundColor(.white)
                        .overlay(
                            VStack{
                                Text("PROFIT: \(profit)")
                                Text("or")
                                Text("\(calculateProfitPercentage(profit: profit))%")
                                    .foregroundColor(Color("bluePattern"))
                                    .font(.custom("Inter-Bold", size: 30))
                            }
                        )
                    Spacer()
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 344, height: 63)
                        .foregroundColor(.white)
                        .overlay(
                            Button(action: resetData) {
                                Text("Recalculate")
                                    .foregroundColor(Color("bluePattern"))
                            }
                        )
                }
            }
        }
    }
    
    private func resetData() {
        entryPrice = 0
        exitPrice = 0
        sharesAmount = 0
        feePercentage = 0
        profit = 0
    }
    
    private func calculateProfitPercentage(profit: Int) -> Int {
        guard entryPrice != 0 && sharesAmount != 0 else {
            return 0
        }
        
        let totalInvestment = entryPrice * sharesAmount
        let profitPercentage = Int((Double(profit) / Double(totalInvestment)) * 100)
        return profitPercentage
    }

    
    private func calculatePNL() {
        if entryPrice != 0 && exitPrice != 0 && sharesAmount != 0 {
            let pnl = (exitPrice - entryPrice) * sharesAmount
            let feeApplied = pnl >= 0 ? (feePercentage * pnl / 100) : 0
            profit = pnl - feeApplied
        } else {
            profit = 0
        }
    }

    }
#Preview {
    NPLAssistantView()
}
