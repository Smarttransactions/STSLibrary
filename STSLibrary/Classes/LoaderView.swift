//
//  LoaderView.swift
//  Pods
//
//  Created by Chetu-macmini-27 on 26/12/16.
//
//

import UIKit

class LoaderView: UIView {
    let kLoaderType = 0
    let loaderBlackViewHeight:CGFloat = 60
    let loaderBlackViewWidth:CGFloat = 200
    let radians:(CGFloat)->CGFloat =  {(degree:CGFloat)->CGFloat in ((degree * 3.14) / 180.0)}
    let Activity_Indicator_Height:CGFloat = 20
    let Activity_Indicator_Width:CGFloat = 20
    let Loader_Label_Height = 25
    let kLoaderLabelYPos = 0
    let kLoaderLabelText = "Please Wait..."
    let kMarginBetweenLabelAndActivityIndicator:CGFloat = 10
    
    override init(frame:CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initLoader(){
        var windowHeight:CGFloat;
        var windowWidth:CGFloat;
        var activityIndicatorFrame:CGRect;
        var loaderLabelText = "";
        windowHeight = UIScreen.main.bounds.size.height
        windowWidth = UIScreen.main.bounds.size.width
        self.frame = CGRect(x: 0, y: 0, width: windowWidth, height: windowHeight)
        activityIndicatorFrame = CGRect(x: (loaderBlackViewWidth-Activity_Indicator_Width)/2, y: (loaderBlackViewHeight-Activity_Indicator_Height)/2+kMarginBetweenLabelAndActivityIndicator, width: Activity_Indicator_Width, height: Activity_Indicator_Height)
        loaderLabelText=kLoaderLabelText;
        self.backgroundColor = UIColor.clear
        self.alpha = 0.8;
        let blackView = UIView(frame: CGRect(x: (windowWidth-loaderBlackViewWidth)/2, y: (windowHeight-loaderBlackViewHeight)/2, width: loaderBlackViewWidth, height: loaderBlackViewHeight))
        blackView.backgroundColor = UIColor.black
        blackView.layer.cornerRadius = 10;
        let reloadingLabel =  UILabel(frame: CGRect(x: 0, y: CGFloat(kLoaderLabelYPos), width: CGFloat(loaderBlackViewWidth), height: CGFloat(Loader_Label_Height)))
        reloadingLabel.text = loaderLabelText;
        reloadingLabel.textAlignment = NSTextAlignment.center
        reloadingLabel.textColor = UIColor.white
        reloadingLabel.font = UIFont (name: "Arial-BoldMT", size: 16);
        reloadingLabel.backgroundColor = UIColor.clear
        blackView.addSubview(reloadingLabel)
        let indicatorView =  UIActivityIndicatorView(frame: activityIndicatorFrame)
        indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        indicatorView.startAnimating()
        blackView.addSubview(indicatorView)
        self.addSubview(blackView)
    }
    
}
