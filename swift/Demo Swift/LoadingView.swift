//
//  LoadingView.swift
//  Demo Swift
//
//  Created by Kennedy Noia on 27/01/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    var activityIndicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(red: 0,
                                                    green: 0,
                                                    blue: 0,
                                                    alpha: 0.5)
        activityIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        self.addSubview(activityIndicator!)
        activityIndicator.center = self.center
        self.activityIndicator?.startAnimating()
        self.hide()
    }
    
    func show(){
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
}
