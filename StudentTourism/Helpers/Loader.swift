//
//  Loader.swift
//  Festa
//
//  Created by Ivan Kopiev on 10.10.2022.
//

import Lottie

struct Loader {
    enum Animations: String { case mastercard, loading }

    static func show(title: String = "", animation: Animations = .loading) {
        DispatchQueue.main.async {
            LoaderOwner.shared.show(title: title, animation: animation.rawValue)
        }
    }
    
    static func hide() {
        DispatchQueue.main.async { LoaderOwner.shared.hide() }
    }
    
    static func show(time: Double = 0, title: String = "", animation: Animations = .loading) {
        DispatchQueue.main.async {
            LoaderOwner.shared.show(title: title, animation: animation.rawValue)
            DispatchQueue.main.asyncAfter(deadline: .now() + time) { Loader.hide() }
        }
    }
}

private class LoaderOwner {
    static let shared = LoaderOwner()
    private init() {}
    private var loader: LoaderView?
    
    func show(title: String = "", animation: String) {
		if loader?.superview == nil { // без этой проверки при быстром вызове 2 лоадеров подряд могла возникнуть ситуация что лоадер уже в subview, а мы крепим туда второй, в итоге появлялся не уираемый лоадер
            loader = LoaderView(title: title, animation: animation)
			guard let loader = loader, let window = UIApplication.shared.windows.first, let topVC = UIApplication.topViewController() else {return}
			if animation == Loader.Animations.loading.rawValue {
				topVC.view.addSubview(loader)
				topVC.view.bringSubviewToFront(loader)
				loader.frame = topVC.view.frame
				if topVC.isModalInPresentation {
					loader.layer.zPosition = 1
				}
			} else {
				window.addSubview(loader)
				window.bringSubviewToFront(loader)
				loader.frame = window.frame
			}
			loader.autoresizingMask = [.flexibleWidth, .flexibleHeight]
			loader.alpha = 0
			UIView.animate(withDuration: 0.5) { loader.alpha = 1}
		}
    }
    
    
    
    func hide() {
        if loader?.superview != nil {
            UIView.animate(withDuration: 0.3) {
                self.loader?.alpha = 0
            } completion: { _ in
                self.loader?.removeFromSuperview()
                self.loader = nil
            }
        }
    }
}

private
class LoaderView: UIView {
    
   private let loadingView: AnimationView = {
        let view = AnimationView()
        view.animation = Animation.named("loading")
        view.animationSpeed = 1
        view.alpha = 1
        view.loopMode = .loop
        view.contentMode = .scaleAspectFill
        view.play()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        return label
    }()
    
    private lazy var blurView: BlurView = {
        let view = BlurView(radius: 6, color: .fDarkGray, colorAlpha: 0.5)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = frame
        return view
    }()
    
    override private init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required fileprivate init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(title: String) {
        self.init()
        titleLabel.text = title
    }
    
    convenience init(title: String, animation: String) {
        self.init()
        titleLabel.text = title
		setUp(animation: animation)
        loadingView.animation = Animation.named(animation)
        loadingView.play()
    }
    
	private func setUp(animation: String) {
		if animation == Loader.Animations.loading.rawValue {
			addSubview(loadingView)
			NSLayoutConstraint.activate([
				loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
				loadingView.centerYAnchor.constraint(equalTo: centerYAnchor),
				loadingView.widthAnchor.constraint(equalToConstant: 57),
				loadingView.heightAnchor.constraint(equalTo: loadingView.widthAnchor)
			])
		} else {
			backgroundColor = .black.withAlphaComponent(0.2)
			addSubview(blurView)
			addSubview(titleLabel)
			addSubview(loadingView)
			NSLayoutConstraint.activate([
				loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
				loadingView.centerYAnchor.constraint(equalTo: centerYAnchor),
				loadingView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45),
				loadingView.heightAnchor.constraint(equalTo: loadingView.widthAnchor),
				
				titleLabel.topAnchor.constraint(equalTo: loadingView.bottomAnchor, constant: 20),
				titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
				titleLabel.widthAnchor.constraint(equalTo: loadingView.widthAnchor, multiplier: 2),
			])
		}
    }
    
    deinit {
        print("Deinit *****Loader****")
    }
}
