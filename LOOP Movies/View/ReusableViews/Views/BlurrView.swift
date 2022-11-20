//
//  BlurrView.swift
//  LOOP Movies
//
//  Created by SIMON on 18/11/22.
//

import Foundation
import UIKit
public class BlurView: UIView {
    var blurView : UIVisualEffectView!
    init() {
        super.init(frame: .zero)
        let blurEffect = UIBlurEffect(style:  .light)
        if #available(iOS 10.0, *) {
            self.blurView = EffectsView.init(effect: blurEffect, intensity: 1.5)
        } else {
            self.blurView.effect = blurEffect
        }
        self.addSubview(blurView)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.blurView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }
}
@available(iOS 10.0, *)
class EffectsView : UIVisualEffectView {
    private var animator: UIViewPropertyAnimator!
    
    init(effect: UIVisualEffect, intensity: CGFloat) {
        super.init(effect: nil)
        animator = UIViewPropertyAnimator(duration:1, curve:.linear){[unowned self] in self.effect = effect}
        animator.fractionComplete = intensity
        if #available(iOS 11.0, *) {
            animator.pausesOnCompletion  = true
        } else {
           
        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        self.roundCorners([.topLeft, .topRight], radius: 10)
    }
}
