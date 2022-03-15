//
//  PhotoViewController.swift
//  PhotoGallery
//
//  Created by Tatiana Luzanova on 15.03.2022.
//

import UIKit

class PhotoViewController: UIViewController {
    
    private var downloadLabel = UILabel()
    private var photoImage = UIImageView()
    private var photo: UIImage
    
// MARK: - Init
    init(photo: UIImage) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupPhotoImage()
        setupLabel()
        setupLayout()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func setupPhotoImage() {
        photoImage.contentMode = .scaleAspectFit
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        photoImage.image = photo
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(photoImageTapped(tapGestureRecognizer:)))
        photoImage.isUserInteractionEnabled = true
        photoImage.addGestureRecognizer(tapGestureRecognizer)
        view.addSubview(photoImage)
    }
    
    private func setupLabel() {
        downloadLabel.text = "date of download: "
        downloadLabel.font = UIFont.systemFont(ofSize: 20)
        downloadLabel.tintColor = UIColor.black
        downloadLabel.translatesAutoresizingMaskIntoConstraints = false
        photoImage.addSubview(downloadLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            downloadLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            downloadLabel.heightAnchor.constraint(equalToConstant: 25),
            downloadLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            photoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            photoImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            photoImage.bottomAnchor.constraint(equalTo: downloadLabel.topAnchor, constant: -20),
        ])
    }
    
    @objc func photoImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if view.backgroundColor == UIColor.black {
            view.backgroundColor = UIColor.white
            downloadLabel.isHidden = false
            navigationController?.navigationBar.isHidden = false
        } else {
            view.backgroundColor = UIColor.black
            downloadLabel.isHidden = true
            navigationController?.navigationBar.isHidden = true
        }
    }
}
