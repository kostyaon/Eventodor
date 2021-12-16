//
//  AwardsViewController.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 14.12.21.
//

import UIKit

class AwardsViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Properties
    private let sectionsNumber = 2
    private let collectionViewInsets = UIEdgeInsets(top: 315.0, left: 0.0, bottom: 0.0, right: 0.0)
    private let gradientLayer: CAGradientLayer = {
        let colors = [
            UIColor(red: 248/256, green: 133/256, blue: 133/256, alpha: 1.0).cgColor,
            UIColor(red: 254/256, green: 195/256, blue: 195/256, alpha: 1.0).cgColor,
            UIColor(red: 216/256, green: 216/256, blue: 216/256, alpha: 1.0).cgColor
        ]
        let layer = CAGradientLayer()
        layer.type = .radial
        layer.colors = colors
        layer.startPoint = CGPoint(x: 0.6, y: 0.2)
        layer.endPoint = CGPoint(x: 0.0, y: 0.0)
        layer.locations = [0.15, 0.7, 1.0]
        return layer
    }()
    
    // MARK: - CollectionView Layout Properties
    private let sectionInsets = UIEdgeInsets(top: 30, left: 20, bottom: 24, right: 20)
    private var availableWidth: CGFloat {
        collectionView.frame.width
    }
    private var availableHeight: CGFloat {
        collectionView.frame.height - collectionViewInsets.top
    }
    
    // MARK: - Lifecycle method's
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        setupCollectionView()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }

    // MARK: - Private method's
    private func setupUI() {
        setupGradient()
        setupTitle()
    }
    
    private func setupTitle() {
        titleLabel.font = .boldSystemFont(ofSize: 36)
        titleLabel.textColor = .white
        titleLabel.text = "awards_title".localized()
    }
    
    private func setupGradient() {
        gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.height, height: view.frame.height)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = collectionViewInsets
        collectionView.register(LabelCollectionCell.nib, forCellWithReuseIdentifier: LabelCollectionCell.reuseId)
        collectionView.register(RewardCollectionCell.nib, forCellWithReuseIdentifier: RewardCollectionCell.reuseId)
    }
}

// MARK: - CollectionView Delegate and Data Source
extension AwardsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionsNumber
      }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if (AppEnvironment.isRegisterOnEvent ?? false) {
                return 1
            } else {
                return 0
            }
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCollectionCell.reuseId, for: indexPath)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RewardCollectionCell.reuseId, for: indexPath) as? RewardCollectionCell
            cell?.configureCell(text: "First step", imageName: "award4")
            return cell ?? UICollectionViewCell()
        default:
            return UICollectionViewCell()
        }
    }
    
    // DelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: availableWidth, height: 95)
        case 1:
            let width = availableWidth / 2
            return CGSize(width: width, height: 286)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
