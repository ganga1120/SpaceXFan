//
//  FavoritesViewModel.swift
//  SpaceXFan
//
//  Created by ggajulapati on 22/05/21.
//

import Foundation

class FavoritesViewModel {
 
    
    var reloadTableViewDataForFavselected: (() -> Void)?

    func getTitleName() -> String {
        return Constants.Titles.favorites
    }
    
    func getFavoritesItemsList() {
    }
    
    func getFavoritesItemsCount() -> Int {
        let arr = Singleton.shared.spaceRocketsList.filter({ $0.isFavorite == true})
        return arr.count
    }
    
    func getFavoritesItemsArray() -> [SpaceRocketsListModel] {
        let favoritesArray = Singleton.shared.spaceRocketsList.filter({ $0.isFavorite == true})
        return favoritesArray
    }
    
    
}
