//
//  Singleton.swift
//  SpaceXFan
//
//  Created by ggajulapati on 24/05/21.
//

import Foundation

class Singleton {
    
    static let shared = Singleton()
    
    private init() {}
        
    var spaceRocketsList: [SpaceRocketsListModel] = [ ]

    var selectedSpaceRocketDetails: SpaceRocketsListModel?

}
