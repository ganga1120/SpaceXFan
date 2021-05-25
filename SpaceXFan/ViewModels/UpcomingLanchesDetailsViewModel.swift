//
//  UpcomingLanchesDetailsViewModel.swift
//  SpaceXFan
//
//  Created by ggajulapati on 23/05/21.
//

import Foundation

class UpcomingLanchesDetailsViewModel {
 
    var selectedUpcomingLanchesDetails: UpcomingLaunchesListModel?

    func getName() -> String? {
        return selectedUpcomingLanchesDetails?.name
    }
    
    func getArticalUrl() -> String? {
        return selectedUpcomingLanchesDetails?.links?.article
    }
}
