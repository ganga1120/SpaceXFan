//
//  Constants.swift
//  SpaceXFan
//
//  Created by ggajulapati on 22/05/21.
//

import Foundation

struct Constants {
    
    struct Cells {
        static let spaceRocketsListCell = "SpaceRocketsListCell"
        static let upcomingLaunchesCell = "UpcomingLaunchesCell"
    }
    
    struct Titles {
        static let home = "Home"
        static let favorites = "Favorites"
        static let note = "Do long press to select location"

    }
    
    struct URL {
        static let spaceRocketsListUrl  = "https://api.spacexdata.com/v4/rockets"
        static let upcomingLaunchesUrl = "https://api.spacexdata.com/v4/launches"
    }
    
    struct Alert {
        static let ok = "Ok"
        static let alertTitle = "Alert"
        static let alertMessaasgeTouchId = "Please enable faceId or TouchId in settings"
        static let alertMessaagelogin = "You Have Successfully Logged in to SpaceXFan"
        static let alertMessaageValidEmail = "Please enter the vaild email address"
        static let alertMessaageAllfieldsrequired = "Please enter all fields."


    }
    
    struct Identifiers {
        static let homeViewController = "HomeViewController"
        static let favoritesViewController = "FavoritesViewController"
        static let upcomingLaunchesViewController = "UpcomingLaunchesViewController"
        static let detailsViewController = "DetailsViewController"
        static let upcomingLanchesDetailsVC = "UpcomingLanchesDetailsVC"
        static let signInViewController = "SignInViewController"
    }
    
}
