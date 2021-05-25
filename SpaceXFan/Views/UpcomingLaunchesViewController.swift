//
//  UpcomingLaunchesViewController.swift
//  SpaceXFan
//
//  Created by ggajulapati on 22/05/21.
//

import UIKit

class UpcomingLaunchesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let upcomingviewModel =  UpcomingLanchesViewModel()
    
    lazy var loader : LoaderView = {
        let viewModel = LoaderView()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    private func setUI() {
        self.title = upcomingviewModel.getNaigationTitle()
        self.setUpTableView()
    }
    
    private func setUpTableView() {
        tableView.register(UINib(nibName: Constants.Cells.upcomingLaunchesCell, bundle: nil), forCellReuseIdentifier: Constants.Cells.upcomingLaunchesCell)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension

        loader.show(in: self.view)
        upcomingviewModel.getUpcomingLaunchesDetails(serviceUrl: upcomingviewModel.upcomingLaunchesListUrl) { (success, error) in
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
        
}

// MARK: - UITableViewDelegate and UITableViewDataSource methods

extension UpcomingLaunchesViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingviewModel.upcomingLaunchesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.upcomingLaunchesCell, for: indexPath) as? UpcomingLaunchesCell else {
            return  UITableViewCell()
        }
        cell.seletedUpcomingLaunchesItem = upcomingviewModel.upcomingLaunchesList[indexPath.row]
        
        return cell
    }
   
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        guard let upcomingLanchesDetailsVC = self.storyboard?.instantiateViewController(identifier: Constants.Identifiers.upcomingLanchesDetailsVC) as? UpcomingLanchesDetailsVC else {
            return
        }
        upcomingLanchesDetailsVC.upcomingLanchesDetailsViewModel.selectedUpcomingLanchesDetails = upcomingviewModel.upcomingLaunchesList[indexPath.row]
        self.navigationController?.pushViewController(upcomingLanchesDetailsVC, animated: true)
        
    }
}
