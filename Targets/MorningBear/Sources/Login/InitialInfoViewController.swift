//
//  InitialInfoViewController.swift
//  MorningBear
//
//  Created by 이건우 on 2023/01/11.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit
import MorningBearUI

import RxSwift
import RxCocoa

class InitialInfoViewController: UIViewController {
    
    private let bag = DisposeBag()
    private let viewModel = InitialInfoViewModel()
    
    private lazy var pageViewController: UIPageViewController = {
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return pageVC
    }()
    
    private lazy var innerScrollView = pageViewController.view.subviews.compactMap{ $0 as? UIScrollView }.first
    
    private lazy var infoInputViewControllers: [UIViewController] = {
        let storyboard = UIStoryboard(name: "InitialInfo", bundle: nil)
        let setWakeUpTimeVC = storyboard.instantiateViewController(withIdentifier: "SetWakeupTime") as! SetWakeupTimeViewController
        let setActivityVC = storyboard.instantiateViewController(withIdentifier: "SetActivity") as! SetActivityViewController
        let setGoalVC = storyboard.instantiateViewController(withIdentifier: "SetGoal") as! SetGoalViewController
        let setProfileVC = storyboard.instantiateViewController(withIdentifier: "SetProfile") as! SetProfileViewController
        
        setWakeUpTimeVC.viewModel = viewModel
        setActivityVC.viewModel = viewModel
        setGoalVC.viewModel = viewModel
        setProfileVC.viewModel = viewModel
        
        return [
            setWakeUpTimeVC,
            setActivityVC,
            setGoalVC,
            setProfileVC
        ]
    }()
    
    @IBOutlet weak var navigationBar: UIView! {
        didSet {
            navigationBar.backgroundColor = MorningBearUIAsset.Colors.primaryBackground.color
        }
    }
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 12
            nextButton.titleLabel?.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
            nextButton.setTitle("다음", for: .normal)
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 20)
            titleLabel.text = "회원가입"
        }
    }
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.setImage(MorningBearUIAsset.Images.backArrow.image, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setPageViewController()
        setDelegate()

        bindButton()
        bindCurrentIndexWithView()
    }
    
    private func setView() {
        view.addSubview(pageViewController.view)
        view.sendSubviewToBack(pageViewController.view)
        navigationController?.isNavigationBarHidden = true
        
        view.backgroundColor = MorningBearUIAsset.Colors.primaryBackground.color
    }
    
    private func setPageViewController() {
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        innerScrollView?.bounces = false
        innerScrollView?.isScrollEnabled = false
        
        NSLayoutConstraint.activate([
            navigationBar.bottomAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        if let firstVC = infoInputViewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: false)
        }
    }
    
    private func setDelegate() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }
    
    private func bindButton() {
        nextButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                let currentIndex = owner.viewModel.currentIndex.value
                owner.viewModel.currentIndex.accept(currentIndex + 1)
                owner.viewModel.canGoNext.accept(owner.viewModel.canGoNext.value)
            }
            .disposed(by: bag)
        
        backButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                let currentIndex = owner.viewModel.currentIndex.value
                if currentIndex == 0 {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    owner.viewModel.currentIndex.accept(currentIndex - 1)
                    owner.viewModel.canGoNext.accept(owner.viewModel.canGoNext.value)
                }
            }
            .disposed(by: bag)
    }
    
    private func bindCurrentIndexWithView() {
        viewModel.currentIndex.withUnretained(self)
            .bind { owner, index in
                guard index >= 0 else { return }
                guard index + 1 <= owner.infoInputViewControllers.count else {
                    owner.viewModel.completeInitialStep()
                    return
                }
                
                let nextView = owner.infoInputViewControllers[index]
                owner.pageViewController.setViewControllers(
                    [nextView],
                    direction: owner.viewModel.oldIndex < index ? .forward : .reverse,
                    animated: true
                )
                owner.viewModel.oldIndex = index
            }
            .disposed(by: bag)
        
        viewModel.canGoNext.withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { owner, canGoNext in
                let currentValue = owner.viewModel.canGoNext.value[owner.viewModel.currentIndex.value]
                owner.nextButton.isEnabled = currentValue ? true : false
                owner.nextButton.backgroundColor = currentValue ? MorningBearUIAsset.Colors.primaryDefault.color : MorningBearUIAsset.Colors.gray800.color
                owner.nextButton.setTitleColor(currentValue ? .white : MorningBearUIAsset.Colors.captionText.color, for: .normal)
            }
            .disposed(by: bag)
    }
}


/// just return nil to disable swipe gesture
extension InitialInfoViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
}
extension InitialInfoViewController: UIPageViewControllerDelegate {}
