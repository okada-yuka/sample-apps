//
//  ViewController.swift
//  SPStorkController#73
//
//  Created by Yuka Okada on 2021/05/11.
//

import UIKit
import SPStorkController

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    @IBAction func showNextVC(_ sender: Any) {
        guard let sb = storyboard,
            let vc = sb.instantiateViewController(withIdentifier: "NextVC") as? NextViewController else { return }

        let transitionDelegate = SPStorkTransitioningDelegate()
        
        // transitionDelegateのカスタマイズはここで行う
        //（vc.transitioningDelegate = transitionDelegateの前）
        transitionDelegate.customHeight = 450
        transitionDelegate.indicatorColor = UIColor.white
        transitionDelegate.indicatorMode = .alwaysArrow
        // Exitボタン（×）を表示するか
        transitionDelegate.showCloseButton = false
        // 後ろにある親をタップすることで閉じるようにするか
        transitionDelegate.tapAroundToDismissEnabled = true
        // 子Viewの角度（コーナをどれだけ丸くするか）
        transitionDelegate.cornerRadius = 70
        
        vc.transitioningDelegate = transitionDelegate
        vc.modalPresentationStyle = .custom
        vc.modalPresentationCapturesStatusBarAppearance = true
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
}

