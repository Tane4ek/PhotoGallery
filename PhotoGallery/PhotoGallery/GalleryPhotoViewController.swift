//
//  GalleryPhotoViewController.swift
//  PhotoGallery
//
//  Created by Tatiana Luzanova on 06.03.2022.
//

import UIKit
import Kingfisher

class GalleryPhotoViewController: UICollectionViewController {
    
    var networkDataFetcher = NetworkDataFeatcher()
    
    private let itemsPerRow: CGFloat = 4
    private let sectionInserts = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    private var photos: [UnsplashPhoto] = []
    private var pageNumber = Int()
    private var isLoading = false
    var totalCount = Int()
    
    private var cellImage = UIImage()
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: - LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateDataFromServer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        pageNumber = 1
        setupCollectionView()
        setupNavigationBar()
    }
    
    private func updateDataFromServer() {
        self.networkDataFetcher.fetchImages(page: pageNumber, completion: { [weak self](searchResults) in
            guard let fetchPhotos = searchResults else {
                self?.showAlert()
                return }
            self?.photos += fetchPhotos.results
            self?.totalCount = fetchPhotos.total
            self?.collectionView.reloadData()
            self?.isLoading = false
        })
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Attension!", message: "The Internet connection appears to be offline", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func loadNextPage() {
        if !isLoading {
            if totalCount > (photos.count){
                isLoading = true
                pageNumber += 1
                updateDataFromServer()
            }
        } else {
            print("загрузка не завершена")
        }
    }
    
    private func setupCollectionView() {
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reusedID)
        collectionView.backgroundColor = UIColor.white
        collectionView.refreshControl = refreshControl
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.contentInsetAdjustmentBehavior = .automatic
    }
    
    // MARK: - NavigationItems
    private func setupNavigationBar() {
        title = "Gallery"
    }
    
    @objc func pullToRefresh(sender: UIRefreshControl) {
        pageNumber = 1
        photos.removeAll()
        updateDataFromServer()
        sender.endRefreshing()
    }
    
    // MARK: - UICollectionViewDataSource, UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reusedID, for: indexPath) as! PhotoCell
        if !photos.isEmpty {
            cell.configure(model: photos[indexPath.row], indexPath: indexPath.row)
            let urlString = photos[indexPath.row].urls["small"]!
            if cell.index == indexPath.row {
                cell.setImage(url: urlString)
            }
        }
        if indexPath.row == photos.count - 1 {
            loadNextPage()
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let image = photos[indexPath.row].urls["small"],
            let createDate = photos[indexPath.row].createdAt as? String
        else {return}
        let photoViewController = PhotoViewController(photo: image, createdDate: createDate)
        navigationController?.pushViewController(photoViewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GalleryPhotoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = photos[indexPath.item]
        let paddingSpace = sectionInserts.left * (itemsPerRow + 1)
        let avaliableWidth = view.frame.width - paddingSpace
        let widthPerItem = avaliableWidth / itemsPerRow
        let height = CGFloat(photo.height) * widthPerItem / CGFloat(photo.width)
        return CGSize(width: widthPerItem, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}
