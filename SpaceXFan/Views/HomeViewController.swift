//
//  ViewController.swift
//  SpaceXFan
//
//  Created by ggajulapati on 22/05/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let homeviewModel =  HomeViewModel()
    
    lazy var loader : LoaderView = {
        let viewModel = LoaderView()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        homeviewModel.reloadTableViewDataForFavselected = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.reloadTabelView()
    }
    
    private func setUI() {
        self.title = homeviewModel.getTitleName()
        self.setupNavigationBar()
        self.setUpTableView()
    }
    
    private func setupNavigationBar() {
        let loginBtn = UIBarButtonItem(title: "Login", style: .plain, target: self, action: #selector(loginButtonClicked))
        navigationItem.rightBarButtonItems = [loginBtn]
    }
    
    private func setUpTableView() {
        tableView.register(UINib(nibName: Constants.Cells.spaceRocketsListCell, bundle: nil), forCellReuseIdentifier: Constants.Cells.spaceRocketsListCell)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        self.getSpaceRocketsDetails()
        
    }
    
    @objc private func loginButtonClicked() {
        guard let signInViewController = self.storyboard?.instantiateViewController(identifier: Constants.Identifiers.signInViewController) as? SignInViewController else {
            return
        }
        let navController = UINavigationController(rootViewController: signInViewController)
        self.present(navController, animated: true, completion: nil)
    }
    
    private func getSpaceRocketsDetails() {
        loader.show(in: self.view)
        homeviewModel.getSpaceRocketsDetails(serviceUrl: homeviewModel.spaceRocketsListUrl) { (success, error) in
            DispatchQueue.main.async { [weak self] in
                self?.loader.dismiss()
                if success {
                    self?.tableView.reloadData()
                } else {
                    self?.showAlert(title:nil, message: error?.localizedDescription ?? "")
                }
            }
        }
    }
    
    private func reloadTabelView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource methods

extension HomeViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Singleton.shared.spaceRocketsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.spaceRocketsListCell, for: indexPath) as? SpaceRocketsListCell else {
            return  UITableViewCell()
        }
        cell.seletedSpaceRocketItem = Singleton.shared.spaceRocketsList[indexPath.row]
        cell.favBtn.tag = indexPath.row
        cell.favBtn.addTarget(self, action: #selector(self.favButtonSelected(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    @objc func favButtonSelected(_ sender: UIButton) {
        homeviewModel.updatedFavSelected(spaceRocketsListModel: Singleton.shared.spaceRocketsList[sender.tag])
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        guard let detailsViewController = self.storyboard?.instantiateViewController(identifier: Constants.Identifiers.detailsViewController) as? DetailsViewController else {
            return
        }
        
        Singleton.shared.selectedSpaceRocketDetails = Singleton.shared.spaceRocketsList[indexPath.row]
        detailsViewController.detailsViewModel.tabType = .homeTab
        detailsViewController.delegate = self
        self.navigationController?.pushViewController(detailsViewController, animated: true)
        
    }
}


// MARK: - FavouriteDelegate methods

extension HomeViewController: FavouriteDelegate {
    
    func updateListWithFavouriteItem(spaceRocketsListModel: SpaceRocketsListModel) {
        homeviewModel.updatedFavSelected(spaceRocketsListModel: spaceRocketsListModel)
    }
}
