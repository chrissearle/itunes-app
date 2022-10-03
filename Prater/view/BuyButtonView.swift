//
//  BuyButtonView.swift
//  Prater
//
//  Created by Chris Searle on 28/09/2022.
//

import SwiftUI

struct BuySongButtonView: View {
    let song: Song

    var body: some View {
        if let price = song.trackPrice {
            BuyButtonView(urlString: song.previewURL, price: price, currency: song.currency)
        } else {
            Text("Album Only")
                .font(.footnote)
                .foregroundColor(Color.gray)
        }
    }
}

struct BuyButtonView: View {
    let urlString: String?
    let price: Double?
    let currency: String?

    var body: some View {
        if let urlString = urlString, let url = URL(string: urlString), let priceText = formattedPrice() {
            Link(destination: url) {
                Text(priceText)
            }
            .buttonStyle(BuyButtonStyle())
        } else {
            EmptyView()
        }
    }
    
    func formattedPrice() -> String? {
        
        guard let price = price else {
            return nil
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        
        return formatter.string(from: NSNumber(value: price))
    }
}

struct BuyButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BuyButtonView(urlString: Song.example().trackViewURL, price: Song.example().trackPrice, currency: Song.example().currency)
    }
}
