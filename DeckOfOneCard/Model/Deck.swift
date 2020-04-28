//
//  Deck.swift
//  DeckOfOneCard
//
//  Created by Leonardo Diaz on 4/28/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import Foundation

struct Deck: Decodable {
    let cards: [Cards]
}

struct Cards: Decodable {
    let image: URL
    let value: String
    let suit: String
}
