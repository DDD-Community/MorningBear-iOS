//
//  OnboardingViewController.swift
//  MorningBear
//
//  Created by 이건우 on 2022/12/14.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit
import MorningBearUI

import RxSwift
import RxCocoa

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var onboardingCollectionView: UICollectionView! {
        didSet {
            onboardingCollectionView.contentMode = .top
            onboardingCollectionView.backgroundColor = .clear
            onboardingCollectionView.isPagingEnabled = true
            onboardingCollectionView.showsVerticalScrollIndicator = false
            onboardingCollectionView.showsHorizontalScrollIndicator = false
            onboardingCollectionView.isScrollEnabled = true
        }
    }
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl.pageIndicatorTintColor = MorningBearUIAsset.Colors.primary100.color
            pageControl.currentPageIndicatorTintColor = MorningBearUIAsset.Colors.primaryDefault.color
            pageControl.backgroundColor = .clear
        }
    }
    @IBOutlet weak var startButton: UIButton! {
        didSet {
            startButton.backgroundColor = MorningBearUIAsset.Colors.primaryDefault.color
            startButton.titleLabel?.font = MorningBearUIFontFamily.Pretendard.Typography.headSmall.font
            startButton.titleLabel?.textColor = .white
            startButton.setTitle("시작하기", for: .normal)
            startButton.layer.cornerRadius = 8
        }
    }
    
    private let onboardingViewModel: OnboardingViewModel = OnboardingViewModel()
    private let bag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        registerCells()
        bindButton()
        
        view.backgroundColor = MorningBearUIAsset.Colors.primaryBackground.color
    }
    
    private func setDelegate() {
        onboardingCollectionView.delegate = self
        onboardingCollectionView.dataSource = self
    }
    
    func registerCells() {
        let bundle =  MorningBearUIResources.bundle
        let cellNib = UINib(nibName: OnboardingCell.reuseIdentifier, bundle: bundle)
        onboardingCollectionView.register(cellNib, forCellWithReuseIdentifier: OnboardingCell.reuseIdentifier)
    }
    
    private func bindButton() {
        startButton.rx.tap.bind { _ in
            
        }
        .disposed(by: bag)
    }
}

// MARK: - UICollectionViewDataSource
extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardingViewModel.onboardingData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: OnboardingCell.reuseIdentifier, for: indexPath
        ) as! OnboardingCell
        
        cell.configure(data: onboardingViewModel.onboardingData[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension OnboardingViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(Double(onboardingCollectionView.contentOffset.x / onboardingCollectionView.frame.width).rounded())
        pageControl.currentPage = currentPage
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.frame.width,
            height: collectionView.frame.height
        )
    }
}
