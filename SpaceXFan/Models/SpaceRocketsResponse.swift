//
//  SpaceRocketsResponse.swift
//  SpaceXFan
//
//  Created by ggajulapati on 22/05/21.
//

import Foundation

struct SpaceRocketsListModel: Codable {
    let id: String?
    let name: String?
    var isFavorite: Bool?
    let flickr_images: [String]?
    let active: Bool?
    let cost_per_launch: Int?
    let description: String?
    
}
