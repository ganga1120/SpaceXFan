//
//  UpcomingLanchesViewModel.swift
//  SpaceXFan
//
//  Created by ggajulapati on 22/05/21.
//

import Foundation

class UpcomingLanchesViewModel {
    
    lazy var networkInterface: NetworkInterfaceProtocol = NetworkInterface()

    lazy var upcomingLaunchesList: [UpcomingLaunchesListModel] = [ ]

    
    func getNaigationTitle() -> String {
        return "UpcomingLanches"
    }
    
    var upcomingLaunchesListUrl: String {
        return Constants.URL.upcomingLaunchesUrl
    }
    
    func getUpcomingLaunchesDetails(serviceUrl: String, completion: @escaping (_ success: Bool, _ error: Error?) -> ()) {
        networkInterface.request(serverUrl: serviceUrl) { [weak self] (result: Response<[UpcomingLaunchesListModel]>) in
            switch result {
            case .success(let response):
                self?.getUpcomingLaunchesData(response: response)
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        }
    }
    
    func getUpcomingLaunchesData(response: [UpcomingLaunchesListModel]) {
        self.upcomingLaunchesList = response
        print("getUpcomingLaunchesData",upcomingLaunchesList)
    }
}
