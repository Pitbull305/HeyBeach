//
//  BeachGalleryViewController.swift
//  HeyBeach
//

import UIKit

protocol BeachGalleryViewControllerIn {
    func displayBeachList(_ viewModel: BeachGalleryModel.Fetch.ViewModel.Success)
}

protocol BeachGalleryViewControllerOut {
    func fetchNextBeachListPage()
}

class BeachGalleryViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    var output: BeachGalleryViewControllerOut?
    private let configurator = BeachGalleryConfigurator()
    private var beachList = [BeachGalleryModel.Beach]()
    
    // CollectionView
    private let numberOfCellsPerRow: CGFloat = 1
    private let minimumSpacingBetweenCellsInRow: CGFloat = 10
    private let rowEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    
    // MARK: - UIViewController
    override func awakeFromNib() {
        super.awakeFromNib()
        configurator.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        activityIndicator.isHidden = false
        output?.fetchNextBeachListPage()
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: "BeachCell", bundle: nil), forCellWithReuseIdentifier: "BeachCell")
        collectionView.allowsSelection = false
    }
}

// MARK: - UICollectionViewDataSource
extension BeachGalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beachList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BeachCell", for: indexPath) as! BeachCell
        let beach = beachList[indexPath.item]
        cell.displayContent(beach)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension BeachGalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return rowEdgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpacingBetweenCellsInRow
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.size.width
        let cellWidth = (collectionViewWidth - rowEdgeInsets.left - rowEdgeInsets.right - minimumSpacingBetweenCellsInRow * (numberOfCellsPerRow - 1)) / numberOfCellsPerRow
        let cellHeight = cellWidth * 0.8
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

// MARK: - BeachGalleryViewControllerIn
extension BeachGalleryViewController: BeachGalleryViewControllerIn {
    func displayBeachList(_ viewModel: BeachGalleryModel.Fetch.ViewModel.Success) {
        activityIndicator.isHidden = true
        beachList = viewModel.beachList
        collectionView.reloadData()
    }
}
