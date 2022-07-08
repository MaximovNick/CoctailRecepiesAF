//
//  Margarita.swift
//  CoctailRecepiesAF
//
//  Created by Nikolai Maksimov on 06.07.2022.
//

import Foundation

struct Margarita: Codable {
    let strDrink: String?
    let strCategory: String?
    let strDrinkThumb: String?
    let strInstructions: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    
    var composition: String {
        
        var compositionInStringFormat = "Ingredients: "
        let allIngredients = [
            strIngredient1,
            strIngredient2,
            strIngredient3,
            strIngredient4,
            strIngredient5,
            strIngredient6,
            strIngredient7,
            strIngredient8,
            strIngredient9,
            strIngredient10,
            strIngredient11,
            strIngredient12,
            strIngredient13,
            strIngredient14,
            strIngredient15
        ]
        
        for index in 0...allIngredients.count - 1 {
            if let ingredient = allIngredients[index] {
                compositionInStringFormat += "\n\(ingredient)"
            }
        }
        return compositionInStringFormat
    }
    
    init(drinkData: [String: Any]) {
        
        strDrink = drinkData["strDrink"] as? String
        strCategory = drinkData["strCategory"] as? String
        strDrinkThumb = drinkData["strDrinkThumb"] as? String
        strInstructions = drinkData["strInstructions"] as? String
        strIngredient1 = drinkData["strIngredient1"] as? String
        strIngredient2 = drinkData["strIngredient2"] as? String
        strIngredient3 = drinkData["strIngredient3"] as? String
        strIngredient4 = drinkData["strIngredient4"] as? String
        strIngredient5 = drinkData["strIngredient5"] as? String
        strIngredient6 = drinkData["strIngredient6"] as? String
        strIngredient7 = drinkData["strIngredient7"] as? String
        strIngredient8 = drinkData["strIngredient8"] as? String
        strIngredient9 = drinkData["strIngredient9"] as? String
        strIngredient10 = drinkData["strIngredient10"] as? String
        strIngredient11 = drinkData["strIngredient11"] as? String
        strIngredient12 = drinkData["strIngredient12"] as? String
        strIngredient13 = drinkData["strIngredient13"] as? String
        strIngredient14 = drinkData["strIngredient14"] as? String
        strIngredient15 = drinkData["strIngredient15"] as? String
    }
    
    static func getDrinks(from value: Any) -> [Margarita] {
        guard let drinksData = value as? [String: Any] else { return []}
        var margaritas: [Margarita] = []
        for (_, values) in drinksData {
            guard let drinkDatasss = values as? [[String: Any]] else {return [] }
            
            for drinkData in drinkDatasss {
                
                let margarita = Margarita(drinkData: drinkData)
                
                margaritas.append(margarita)
            }
        }
        return margaritas
    }
}


struct Drink: Codable {
    let drinks: [Margarita]
}
