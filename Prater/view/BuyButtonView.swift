//
//  BuyButtonView.swift
//  Prater
//
//  Created by Chris Searle on 28/09/2022.
//

import SwiftUI

struct BuyButtonView: View {
    let urlString: String?
    let price: Double?
    let currency: String?

    var body: some View {
        if let urlString = urlString, let url = URL(string: urlString), let price = price, let currency = currency {
            Link(destination: url) {
                Text(" \(Int(price)) \(currency)")
            }
            .buttonStyle(BuyButtonStyle())
        } else {
            EmptyView()
        }
        
    }
}

struct BuyButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BuyButtonView(urlString: Song.example().trackViewURL, price: 1.0, currency: "USD")
    }
}
