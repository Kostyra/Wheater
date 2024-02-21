import UIKit


final class PageViewController: UIPageViewController {
    
    //MARK: - Prorepties
    
    private var generalViewController: [GeneralViewController] = []
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        if let initialViewController = generalViewController.first {
            setViewControllers([initialViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Method
    
    func setupGeneralViewControllers() {
        for _ in 0... {
            let generalVC = GeneralViewController(viewModel: [IGeneralViewModel.self] as! IGeneralViewModel)
            generalViewController.append(generalVC)
        }
    }
}


extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard  let viewControllerIndex = generalViewController.firstIndex(of: viewController as! GeneralViewController) else {
            return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return nil }
        guard generalViewController.count > previousIndex else { return nil }
        return generalViewController[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = generalViewController.firstIndex(of: viewController as! GeneralViewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < generalViewController.count else { return nil }
        guard generalViewController.count > nextIndex else { return nil }
        return generalViewController[nextIndex]
    }
    
    
}


