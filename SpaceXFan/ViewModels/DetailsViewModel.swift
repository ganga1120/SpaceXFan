//
//  DetailsViewModel.swift
//  SpaceXFan
//
//  Created by ggajulapati on 22/05/21.
//

import Foundation


enum TabType {
    case homeTab
    case favoritesTab
}

class DetailsViewModel {
    
    //var selectedSpaceRocketDetails: SpaceRocketsListModel?
    
    var tabType: TabType?
    
    var reloadFavUI: (() -> Void)?
    
    func getSpaceRocketName() -> String? {
        return Singleton.shared.selectedSpaceRocketDetails?.name
    }
    
    func getSpaceRocketCostPerLaunch() -> Int? {
        return Singleton.shared.selectedSpaceRocketDetails?.cost_per_launch
    }
    
    func getSpaceRocketDescription() -> String? {
        return Singleton.shared.selectedSpaceRocketDetails?.description
    }
    
    func getSlideImagesCount() -> Int? {
        return Singleton.shared.selectedSpaceRocketDetails?.flickr_images?.count
    }
    
    func getSelectedImageUrl(index: Int) -> String? {
        return Singleton.shared.selectedSpaceRocketDetails?.flickr_images?[index]
    }
    
    func getIsFavorite() -> Bool? {
        return Singleton.shared.selectedSpaceRocketDetails?.isFavorite
    }
    
    func updateFavioriteItem() {
        
        if let isfav = Singleton.shared.selectedSpaceRocketDetails?.isFavorite {
            if isfav {
                Singleton.shared.selectedSpaceRocketDetails?.isFavorite = false
            }else {
                Singleton.shared.selectedSpaceRocketDetails?.isFavorite = true
            }
        }else {
            Singleton.shared.selectedSpaceRocketDetails?.isFavorite = true
        }
        
        self.reloadFavUI?()
    }
    
    
}
