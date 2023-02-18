//
//  BaseVC.swift
//  Festa
//
//  Created by Ivan Kopiev on 04.10.2022.
//

import UIKit

class BaseVC: UIViewController {
    var v: BaseView! { return self.view as? BaseView }
    
    private var _state : [String: Any] = [:]
    public var state : [String: Any] {
        get { _state }
        set {
            _state = newValue;
            v.getState = { [weak self] in self?.state ?? [:]}
            v.render()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    var withNavigationBar: Bool { true }
    var popRecognizer: InteractivePopRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backItem?.title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(!withNavigationBar, animated: false)
        guard let controller = navigationController, !withNavigationBar else { return }
        popRecognizer = InteractivePopRecognizer(controller: controller)
        controller.interactivePopGestureRecognizer?.delegate = popRecognizer
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @objc func returnFromVC() {
        if let navigationController = navigationController
        {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil);
        }
    }

    @IBAction func backBtnPressed(_ sender: UIButton) {
        if let nav = navigationController {
            nav.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
    
    
    func show(vc: UIViewController) {
        if let navigationController = navigationController {
            navigationController.pushViewController(vc, animated: true)
        } else {
            present(vc, animated: true)
        }
    }
    
    func setAttributed(title: NSMutableAttributedString) {
        let label = UILabel(alignment: .center, lines: 0)
        label.attributedText = title
        label.sizeToFit()
        navigationItem.titleView = label
    }
    
    func isLoading(_ isLoading: Bool = true) {
        state[b: .isLoading] = isLoading
    }
}

class InteractivePopRecognizer: NSObject, UIGestureRecognizerDelegate {

    weak var navigationController: UINavigationController?

    init(controller: UINavigationController) {
        self.navigationController = controller
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return navigationController?.viewControllers.count ?? 0 > 1
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool { true }
}

class ContainerVC: BaseVC {
    @IBOutlet var containerVC: UIView!
    var embededViews: [UIView] = []
    
    func embed(viewControllers: UIViewController...) -> [UIView] {
        var views = [UIView]()
        viewControllers.forEach { vc in
            addChild(vc)
            vc.didMove(toParent: self)
            views.append(vc.view)
        }
        return views
    }
    
    func setEmbedView(id: Int) {
        guard id < embededViews.count else { return }
        containerVC.subviews.forEach { $0.removeFromSuperview() }
        containerVC.addSubview(embededViews[id], edges: .top, .left, .right, .bottom)
    }
}

extension String {
    static let isLoading = "isLoading"
}
