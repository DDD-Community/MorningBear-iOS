//
//  OnboardingViewController.swift
//  MorningBear
//
//  Created by 이건우 on 2022/12/14.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var onboardingCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var startButton: UIButton!
    
    // MARK: Variables
    private let onboardingViewModel: OnboardingViewModel = OnboardingViewModel()
    
    // MARK: LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    // MARK: - IBActions
    @IBAction func startButtonTapped(_ sender: Any) { }
    
    // MARK: - Functions
    private func initView() {
        setDelegate()
        setButtonAppearence()
    }
    
    private func setDelegate() {
        onboardingCollectionView.delegate = self
        onboardingCollectionView.dataSource = self
    }
    
    private func setButtonAppearence() {
        startButton.layer.cornerRadius = 8
    }
}

// MARK: - UICollectionViewDataSource
extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardingViewModel.onboardingData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCell
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
