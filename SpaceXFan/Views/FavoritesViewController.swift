//
//  FavoritesViewController.swift
//  SpaceXFan
//
//  Created by ggajulapati on 22/05/21.
//

import UIKit
import LocalAuthentication

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    let favoritesViewModel =  FavoritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        favoritesViewModel.reloadTableViewDataForFavselected = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    private func setUI(){
        self.title = favoritesViewModel.getTitleName()
        self.setUpTableView()
    }
    
    private func setUpTableView() {
        tableView.register(UINib(nibName: Constants.Cells.spaceRocketsListCell, bundle: nil), forCellReuseIdentifier: Constants.Cells.spaceRocketsListCell)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.validateFaceIdOrTouchId()
    }
    
    private func validateFaceIdOrTouchId() {
        
        let myContext = LAContext()
        myContext.evaluatePolicy(
            LAPolicy.deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Authentication is required for access",
            reply: {(success, error) in
                // Code to handle reply here
            })
        let myLocalizedReasonString = "Biometric Authntication "
        var authError: NSError?
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    DispatchQueue.main.async {
                        if success {
                            self.reloadTableView()
                            // User authenticated successfully, take appropriate action
                        } else {
                            print("Sorry!!... User did not authenticate successfully")
                            // User did not authenticate successfully, look at error and take appropriate action
                        }
                    }
                }
            } else {
                // Could not evaluate policy; look at authError and present an appropriate message to user
                if authError != nil {
                    DispatchQueue.main.async {
                        self.showAlert(title:"" , message: Constants.Alert.alertMessaasgeTouchId)
                    }
                }
            }
        } else {
            // Fallback on earlier versions
            print("Ooops!!.. This feature is not supported.")
        }
        
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource methods

extension FavoritesViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesViewModel.getFavoritesItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.spaceRocketsListCell, for: indexPath) as? SpaceRocketsListCell else {
            return  UITableViewCell()
        }
        let favArray = favoritesViewModel.getFavoritesItemsArray()
        cell.seletedSpaceRocketItem = favArray[indexPath.row]
        cell.favBtn.tag = indexPath.row
        cell.favBtn.addTarget(self, action: #selector(self.favButtonSelected(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    @objc func favButtonSelected(_ sender: UIButton) {
        let favArray = favoritesViewModel.getFavoritesItemsArray()
        Util.updatedFavSelected(spaceRocketsListModel: favArray[sender.tag])
        self.reloadTableView()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        guard let detailsViewController = self.storyboard?.instantiateViewController(identifier: Constants.Identifiers.detailsViewController) as? DetailsViewController else {
            return
        }
        let favArray = favoritesViewModel.getFavoritesItemsArray()
        Singleton.shared.selectedSpaceRocketDetails = favArray[indexPath.row]
        detailsViewController.detailsViewModel.tabType = .favoritesTab
        detailsViewController.delegate = self
        self.navigationController?.pushViewController(detailsViewController, animated: true)
        
    }
}


// MARK: - FavouriteDelegate methods

extension FavoritesViewController: FavouriteDelegate {
    func updateListWithFavouriteItem(spaceRocketsListModel: SpaceRocketsListModel) {
        Util.updatedFavSelected(spaceRocketsListModel: spaceRocketsListModel)
        self.reloadTableView()
    }
}
