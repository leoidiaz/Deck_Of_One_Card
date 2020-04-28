//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Leonardo Diaz on 4/28/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import Foundation
import UIKit.UIImage

class CardController {
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=1")
    static func fetchCard(completion: @escaping (Result<Cards, CardError>) -> Void){
        //1 Prepare URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        //2 Contact Server
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            //3 Handle Errors
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            //4 JSON Data
            guard let data = data else {return completion(.failure(.noData))}
            //5 Decode
            do {
                let decoder = JSONDecoder()
                let deck = try decoder.decode(Deck.self, from: data)
                guard let card = deck.cards.first else { return completion(.failure(.noData))}
                completion(.success(card))
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    static func fetchImage(for card: Cards, completion: @escaping (Result<UIImage, CardError>) -> Void) {
        let imageURL = card.image
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            if let error = error {
                print(error, error.localizedDescription)
                completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData)) }
            guard let cardImage = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            completion(.success(cardImage))
        }.resume()
    }
}
