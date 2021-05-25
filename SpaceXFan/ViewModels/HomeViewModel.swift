//
//  HomeViewModel.swift
//  SpaceXFan
//
//  Created by ggajulapati on 22/05/21.
//

import Foundation

class HomeViewModel: NSObject {
    
    lazy var networkInterface: NetworkInterfaceProtocol = NetworkInterface()
    
    lazy var spaceRocketsList: [SpaceRocketsListModel] = [ ]
    
    var reloadTableViewDataForFavselected: (() -> Void)?
    
    var spaceRocketsListUrl: String {
        return Constants.URL.spaceRocketsListUrl
    }
    
    func getTitleName() -> String {
        return Constants.Titles.home
    }
    
    func getSpaceRocketsDetails(serviceUrl: String, completion: @escaping (_ success: Bool, _ error: Error?) -> ()) {
        networkInterface.request(serverUrl: serviceUrl) { [weak self] (result: Response<[SpaceRocketsListModel]>) in
            switch result {
            case .success(let response):
                self?.getSpaceRocketsData(response: response)
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        }
    }
    
    func getSpaceRocketsData(response: [SpaceRocketsListModel]) {
        Singleton.shared.spaceRocketsList = response
    }
    
    func updatedFavSelected(spaceRocketsListModel: SpaceRocketsListModel) {
        Util.updatedFavSelected(spaceRocketsListModel: spaceRocketsListModel)
        self.reloadTableViewDataForFavselected?()
    }
    
}
