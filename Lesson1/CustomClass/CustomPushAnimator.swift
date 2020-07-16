//
//  CustomPushAnimator.swift
//  Lesson1
//
//  Created by Vit K on 21.04.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

let duration = 0.5

final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {duration}
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let source = transitionContext.viewController(forKey: .from)!
        let destination = transitionContext.viewController(forKey: .to)!
        
        transitionContext.containerView.addSubview(destination.view)
        
        destination.view.frame = source.view.frame
        destination.view.transform = CGAffineTransform(rotationAngle: -.pi / 2)
        
        destination.view.layer.anchorPoint = .zero
        source.view.layer.anchorPoint = .zero
        destination.view.layer.position = .zero
        source.view.layer.position = .zero
        
        UIView.animate(withDuration: duration, delay: 0, options: [], animations: {
            destination.view.transform = .identity
            source.view.transform = CGAffineTransform(rotationAngle: .pi / 2)
        }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}


final class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {duration}


    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let source = transitionContext.viewController(forKey: .from)!
        let destination = transitionContext.viewController(forKey: .to)!

        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)

        destination.view.frame = source.view.frame
        destination.view.transform = CGAffineTransform(rotationAngle: .pi / 2)

        destination.view.layer.anchorPoint = .zero
        source.view.layer.anchorPoint = .zero
        destination.view.layer.position = .zero
        source.view.layer.position = .zero
        
        UIView.animate(withDuration: duration, delay: 0, options: [], animations: {
            destination.view.transform = .identity
            source.view.transform = CGAffineTransform(rotationAngle: -.pi / 2)
        }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }

    }

}

class CustomNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBar.tintColor = colorBG
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20),
                                             NSAttributedString.Key.foregroundColor: colorBG]
    }
    
    let interactiveTransition = CustomInteractiveTransition()
    
}

extension CustomNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
                              -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController)
                              -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            self.interactiveTransition.viewController = toVC
            return CustomPushAnimator()
        } else if operation == .pop {
            if navigationController.viewControllers.first != toVC {
                self.interactiveTransition.viewController = toVC
            }
            return CustomPopAnimator()
        }
        return nil
    }
}
