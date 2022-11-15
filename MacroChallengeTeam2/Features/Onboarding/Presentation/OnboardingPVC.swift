//
//  OnboardingPVC.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 04/11/22.
//

import UIKit
import SwiftUI
import SnapKit

class OnboardingPVC: UIPageViewController {
    private var pages: [UIViewController] = []
    private var pageControl = UIPageControl()
    private let initialPage = 0

    private lazy var backgroundMotives: UIImageView = {
        let view = 	UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "onboardBGBack")
        return view
    }()

    private lazy var lanjutBtn: MedButtonView = {
        let btn = MedButtonView(variant: .variant2, title: "Lanjut")
        btn.addAction(
            UIAction(identifier: UIAction.Identifier("next")) { [self] _ in
                pageControl.currentPage += 1
                goToNextPage()
                animateControlsIfNeeded()
            }, for: .touchDown
        )
        view.addSubview(btn)
        return btn
    }()

    private lazy var lewatiBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Lewati Semua", for: .normal)
        btn.titleLabel?.textColor = .white
        btn.titleLabel?.font = .regular17
        view.addSubview(btn)
        btn.addAction(
            UIAction { [self] _ in
                let lastPageIndex = pages.count - 1
                pageControl.currentPage = lastPageIndex
                goToSpecificPage(index: lastPageIndex, ofViewControllers: pages)
                animateControlsIfNeeded()
            }, for: .touchDown)
        return btn
    }()

    private lazy var bgFront: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "onboardBGFront")
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.insertSubview(backgroundMotives, at: 0)
        setupPageControl()
        setupAutoLayout()
    }
}

extension OnboardingPVC {
    func setupPageControl() {
        dataSource = self
        delegate = self

        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)

        let page1 = Onboarding1ViewController()
        let page2 = Onboarding2ViewController()
        let page3 = Onboarding3ViewController()

        pages.append(page1)
        pages.append(page2)
        pages.append(page3)

        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)

        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .init(white: 1, alpha: 0.3)
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        view.addSubview(pageControl)
    }

    func setupAutoLayout() {
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(240)
        }
        backgroundMotives.snp.makeConstraints { make in
            make.width.equalTo(bgFront).offset(11)
            make.height.equalTo(bgFront).offset(14)
            make.center.equalToSuperview()
        }
        lewatiBtn.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(140)
            make.bottom.equalToSuperview().offset(-100)
        }
        lanjutBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-140)
            make.bottom.equalToSuperview().offset(-110)
        }
        bgFront.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
}

// MARK: - DataSource

extension OnboardingPVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        if currentIndex == 0 {
            return nil
        } else {
            return pages[currentIndex - 1]
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return nil
        }
    }
}

// MARK: - Delegates

extension OnboardingPVC: UIPageViewControllerDelegate {
    // How we keep our pageControl in sync with viewControllers
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }

        pageControl.currentPage = currentIndex
        animateControlsIfNeeded()
    }

    private func animateControlsIfNeeded() {
        let lastPage = pageControl.currentPage == pages.count - 1

        if lastPage {
            lanjutBtn.setTitle("Selesai", for: .normal)
            lanjutBtn.removeAction(identifiedBy: UIAction.Identifier("next"), for: .allEvents)
            lanjutBtn.addAction(
                UIAction(identifier: UIAction.Identifier("finish")) { _ in
                    self.navigationController?.pushViewController(MainPageViewController(), animated: true)
                },
                for: .touchDown
            )
            hideControls()
        } else {
            lanjutBtn.setTitle("Lanjut", for: .normal)
            lanjutBtn.removeAction(identifiedBy: UIAction.Identifier("finish"), for: .allEvents)
            lanjutBtn.addAction(
                UIAction(identifier: UIAction.Identifier("next")) { [self] _ in
                    pageControl.currentPage += 1
                    goToNextPage()
                    animateControlsIfNeeded()
                },
                for: .touchDown
            )
            showControls()
        }

        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.5,
            delay: 0,
            options: [.curveEaseInOut],
            animations: {
                self.view.layoutIfNeeded()
            },
            completion: nil)
    }

    private func hideControls() {
        UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
            self.lewatiBtn.alpha = 0.0
        }.startAnimation()
    }

    private func showControls() {
        UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
            self.lewatiBtn.alpha = 1
        }.startAnimation()
    }
}

// MARK: - Actions

extension OnboardingPVC {
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        animateControlsIfNeeded()
    }

    @objc func skipTapped(_ sender: UIButton) {
        let lastPageIndex = pages.count - 1
        pageControl.currentPage = lastPageIndex

        goToSpecificPage(index: lastPageIndex, ofViewControllers: pages)
        animateControlsIfNeeded()
    }

    @objc func nextTapped(_ sender: UIButton) {
        pageControl.currentPage += 1
        goToNextPage()
        animateControlsIfNeeded()
    }
}

// MARK: - Extensions

extension UIPageViewController {
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }

        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }

    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }

        setViewControllers([prevPage], direction: .forward, animated: animated, completion: completion)
    }

    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
    }
}

struct OnboardingPVCPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return OnboardingPVC(transitionStyle: .scroll, navigationOrientation: .horizontal)
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)")
        .previewInterfaceOrientation(.landscapeLeft)
        .ignoresSafeArea()
    }
}
