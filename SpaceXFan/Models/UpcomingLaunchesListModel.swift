//
//  UpcomingLaunchesListModel.swift
//  SpaceXFan
//
//  Created by ggajulapati on 22/05/21.
//

import Foundation

struct UpcomingLaunchesListModel: Codable {
    let name: String?
    let links: Links?
    let details: String?
}

struct Links: Codable {
    let presskit: String?
    let webcast: String?
    let youtubeID: String?
    let article: String?
    let wikipedia: String?
    let patch: Patch?

}

struct Patch: Codable {
    let small: String?
    let large: String?
}


