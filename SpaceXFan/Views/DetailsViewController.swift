//
//  DetailsViewController.swift
//  SpaceXFan
//
//  Created by ggajulapati on 22/05/21.
//

import UIKit
import SDWebImage

protocol FavouriteDelegate {
    func updateListWithFavouriteItem(spaceRocketsListModel: SpaceRocketsListModel)
}

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    @IBOutlet weak var pageView: UIPageControl!
    
    @IBOutlet weak var descriptionTextView :UITextView!
    
    @IBOutlet weak var costPerLaunchLabel: UILabel!
    
    @IBOutlet weak var favbutton: UIButton!
    
    let detailsViewModel = DetailsViewModel()
    
    var timer = Timer()
    
    var counter = 0
    
    var delegate: FavouriteDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setCollctionViewUI()
        
        detailsViewModel.reloadFavUI = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.updateFavUI()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if self.detailsViewModel.tabType == .homeTab {
            self.updateFavUI()
        }
        
    }
    
    private func setUI() {
        
        if let title = detailsViewModel.getSpaceRocketName() {
            self.title = title
        }
        if let description = detailsViewModel.getSpaceRocketDescription() {
            self.descriptionTextView.text = description
        }
        
        if let costPerLaunch = detailsViewModel.getSpaceRocketCostPerLaunch() {
            self.costPerLaunchLabel.text = "CostPerlanuch: " + String(costPerLaunch)
        }
        
        self.updateFavUI()
        
    }
    
    private func updateFavUI() {
        
        if let isfav = detailsViewModel.getIsFavorite() {
            if isfav {
                favbutton.isSelected = true
            }else {
                favbutton.isSelected = false
            }
        }else {
            favbutton.isSelected = false
        }
    }
    
    private func setCollctionViewUI() {
        
        pageView.numberOfPages = detailsViewModel.getSlideImagesCount() ?? 0
        pageView.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    @objc func changeImage() {
        
        if counter < detailsViewModel.getSlideImagesCount() ?? 0 {
            let index = IndexPath.init(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageView.currentPage = counter
            counter = 1
        }
        
    }
    
    @IBAction func favButtonAction(_ sender: Any) {
        
        detailsViewModel.updateFavioriteItem()
        if let selectedSpaceRocketDetails = Singleton.shared.selectedSpaceRocketDetails {
            self.delegate?.updateListWithFavouriteItem(spaceRocketsListModel: selectedSpaceRocketDetails)
        }
        
        if detailsViewModel.tabType == .favoritesTab {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
}


// MARK: - UICollectionViewDelegate and UICollectionViewDataSource methods

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailsViewModel.getSlideImagesCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let imageView = cell.viewWithTag(111) as? UIImageView {
            if let url = detailsViewModel.getSelectedImageUrl(index: indexPath.row) {
                imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))
            }
        }
        return cell
    }
}

extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sliderCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
