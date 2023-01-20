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
    private let viewModel = InitialInfoViewModel.shared
    
    private lazy var pageViewController: UIPageViewController = {
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return pageVC
    }()
    
    private var infoInputViewControllers: [UIViewController] = {
        let storyboard = UIStoryboard(name: "InitialInfo", bundle: nil)
        return [
            storyboard.instantiateViewController(withIdentifier: "SetWakeupTime"),
            storyboard.instantiateViewController(withIdentifier: "SetActivity"),
            storyboard.instantiateViewController(withIdentifier: "SetGoal"),
            storyboard.instantiateViewController(withIdentifier: "SetProfile")
        ]
    }()
    
    @IBOutlet weak var containerView: UIView!
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
        
        setPageViewController()
        setDelegate()
        
        bindButton()
        bindCurrentIndexWithView()
    }
    
    private func setPageViewController() {
        containerView.addSubview(pageViewController.view)
        view.sendSubviewToBack(containerView)
        navigationController?.isNavigationBarHidden = true
        
        if let firstVC = infoInputViewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true)
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
                let currentValue = owner.viewModel.currentIndex.value
                owner.viewModel.currentIndex.accept(currentValue + 1)
            }
            .disposed(by: bag)
        
        backButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                let currentValue = owner.viewModel.currentIndex.value
                if currentValue == 0 {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    owner.viewModel.currentIndex.accept(currentValue - 1)
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
                owner.nextButton.isEnabled = canGoNext ? true : false
                owner.nextButton.backgroundColor = canGoNext ? MorningBearUIAsset.Colors.primaryDefault.color : MorningBearUIAsset.Colors.gray800.color
                owner.nextButton.setTitleColor(canGoNext ? .white : MorningBearUIAsset.Colors.captionText.color, for: .normal)
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

extension InitialInfoViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    }
}
