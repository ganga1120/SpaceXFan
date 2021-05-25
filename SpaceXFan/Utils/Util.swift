//
//  Util.swift
//  SpaceXFan
//
//  Created by ggajulapati on 24/05/21.
//

import Foundation

class Util {
    
    class func updatedFavSelected(spaceRocketsListModel: SpaceRocketsListModel) {
        
        var selctedIndex: Int?
        
        var selectedSpaceRocketsListModel: SpaceRocketsListModel?
        
        if let Id = spaceRocketsListModel.id {
            
            for i in 0..<Singleton.shared.spaceRocketsList.count  {
                if Singleton.shared.spaceRocketsList[i].id == Id {
                    selectedSpaceRocketsListModel = Singleton.shared.spaceRocketsList[i]
                    selctedIndex = i
                    break
                }
            }
        }
        
        if selectedSpaceRocketsListModel?.isFavorite ?? false {
            selectedSpaceRocketsListModel?.isFavorite = false
        }else {
            selectedSpaceRocketsListModel?.isFavorite = true
        }
        
        if let index = selctedIndex, let tempSelectedRocket = selectedSpaceRocketsListModel {
            Singleton.shared.spaceRocketsList[index] = tempSelectedRocket
        }
    }
    
    class func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
