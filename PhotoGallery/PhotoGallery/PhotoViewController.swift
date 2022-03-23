//
//  PhotoViewController.swift
//  PhotoGallery
//
//  Created by Tatiana Luzanova on 15.03.2022.
//

import UIKit
import SDWebImage

class PhotoViewController: UIViewController {
    
    private var createdLabel = UILabel()
    private var photoImage = UIImageView()
    private var photo: String
    private var createdDate: String
    
// MARK: - Init
    init(photo: String, createdDate: String) {
        self.photo = photo
        self.createdDate = createdDate
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
        guard let downLoadURL = URL(string: photo) else { return }
        photoImage.sd_setImage(with: downLoadURL, completed: nil)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(photoImageTapped(tapGestureRecognizer:)))
        photoImage.isUserInteractionEnabled = true
        photoImage.addGestureRecognizer(tapGestureRecognizer)
        view.addSubview(photoImage)
    }
    
    private func setupLabel() {
        createdLabel.text = "date of create: " + convertToDateFormat()
        createdLabel.font = UIFont.systemFont(ofSize: 20)
        createdLabel.tintColor = UIColor.black
        createdLabel.translatesAutoresizingMaskIntoConstraints = false
        photoImage.addSubview(createdLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            createdLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            createdLabel.heightAnchor.constraint(equalToConstant: 25),
            createdLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            photoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            photoImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            photoImage.bottomAnchor.constraint(equalTo: createdLabel.topAnchor, constant: -20),
        ])
    }
    
    @objc func photoImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if view.backgroundColor == UIColor.black {
            view.backgroundColor = UIColor.white
            createdLabel.isHidden = false
            navigationController?.navigationBar.isHidden = false
        } else {
            view.backgroundColor = UIColor.black
            createdLabel.isHidden = true
            navigationController?.navigationBar.isHidden = true
        }
    }
    
    private func convertToDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss-hh:mm"
        print(createdDate)
        guard let theDate = dateFormatter.date(from: createdDate) else {return ""}
        let newDateFormater = DateFormatter()
        newDateFormater.dateFormat = "MM/dd/yyyy, hh:mm:ss"
        let datestring = newDateFormater.string(from: theDate)
        return datestring
    }
}
