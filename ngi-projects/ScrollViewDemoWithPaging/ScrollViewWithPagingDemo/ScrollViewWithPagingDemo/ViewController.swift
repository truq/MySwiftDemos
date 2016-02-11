//
//  ViewController.swift
//  ScrollViewWithPagingDemo
//
//  Created by NGI-NOMAN on 11/6/15.
//  Copyright © 2015 NGI-NOMAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {

     var scrollView2: UIScrollView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet var firstView: UIView!
    @IBOutlet var secondView: UIView!
    @IBOutlet var thirdView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
        view.autoresizesSubviews = true
        scrollView2 = UIScrollView(frame:CGRectMake(0,0,SizeUtil.screenWidth(),SizeUtil.screenHeight()*0.75))
        scrollView2.center.x = SizeUtil.screenWidth()/2
        scrollView2.center.y = SizeUtil.screenHeight()/2
        view.addSubview(scrollView2)
        self.scrollView2.delegate = self
        
        var views:[UIView] = [getFirstView(),getSecondView(),getThirdView()]
        var frame: CGRect = CGRectMake(0, 0, 0, 0)
        
        for index in 0..<views.count {
            
            frame.origin.x = SizeUtil.screenWidth() * CGFloat(index)
            frame.size.width = SizeUtil.screenWidth()
            frame.size.height = scrollView2.frame.size.height
            self.scrollView2.pagingEnabled = true
            
            let subView = views[index]
            subView.frame = frame
            self.scrollView2 .addSubview(subView)
        }
        
        self.scrollView2.contentSize = CGSizeMake(SizeUtil.screenWidth() * CGFloat(views.count),scrollView2.frame.size.height)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let pageWidth = SizeUtil.screenWidth()
        let page = (NSInteger)((self.scrollView2.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0))
        pageControl.currentPage = page
        
    }
    
    
    func getFirstView() -> UIView {
        
        var viewWidth : CGFloat = 0.0
        var viewHeight : CGFloat = 0.0
        
        let view = UIView()
        
        view.frame = CGRectMake(0 , 0,SizeUtil.screenWidth(), scrollView2.frame.size.height)
        view.backgroundColor = UIColor.grayColor()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.grayColor().CGColor
        view.center.x = self.view.frame.size.width/2
        view.center.y = self.view.frame.size.height/2
        
        viewWidth = view.frame.size.width
        viewHeight = view.frame.size.height
        
        let titleLabel = UILabel(frame: CGRectMake(0, 0, SizeUtil.convertIphone6ToIphone5(320), SizeUtil.convertIphone6ToIphone5(100)))
        titleLabel.text = "Welcome! To begin enter the address of each property you own."
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.center.x = viewWidth/2
        titleLabel.center.y = viewHeight*0 + titleLabel.frame.size.height/2
        view.addSubview(titleLabel)

        
        var positionX , positionY : CGFloat
        
        positionX = viewWidth/2 - SizeUtil.convertIphone6ToIphone5(55)
        positionY = titleLabel.center.y + titleLabel.frame.size.height * 0.70
        
        for(var item:Int = 0 ; item < 9; ++item){
            
            let imageViewCenter = UIImageView(frame: CGRectMake(0, 0, SizeUtil.convertIphone6ToIphone5(55), SizeUtil.convertIphone6ToIphone5(55)))
            imageViewCenter.image = UIImage(named:"home-icon.png")
            imageViewCenter.center.x = positionX
            imageViewCenter.center.y = positionY
            view.addSubview(imageViewCenter)
            
            positionY += imageViewCenter.frame.size.height*1.1
            
            if item == 2{
                 positionX = imageViewCenter.center.x + imageViewCenter.frame.size.width
                 positionY = titleLabel.center.y + titleLabel.frame.size.height * 0.7
            }
            else if item == 5 {
                positionX = imageViewCenter.center.x + imageViewCenter.frame.size.width
                positionY = titleLabel.center.y + titleLabel.frame.size.height * 0.70
            }
        }
        
        return view
        
    }
    
    func getSecondView() -> UIView {
        
        var viewWidth : CGFloat = 0.0
        var viewHeight : CGFloat = 0.0
        
        let view = UIView()
        
        view.frame = CGRectMake(0 , 0,SizeUtil.screenWidth(),scrollView2.frame.size.height)
        view.backgroundColor = UIColor.grayColor()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.grayColor().CGColor
        view.center.x = self.view.frame.size.width/2
        view.center.y = self.view.frame.size.height/2
        
        viewWidth = view.frame.size.width
        viewHeight = view.frame.size.height
        
        
        let titleLabel = UILabel(frame: CGRectMake(0, 0, SizeUtil.convertIphone6ToIphone5(320), SizeUtil.convertIphone6ToIphone5(100)))
        titleLabel.text = "We'll tell you how much you paid for each property and what they are worth now!"
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 3
        titleLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.center.x = viewWidth/2
        titleLabel.center.y = viewHeight*0 + titleLabel.frame.size.height/2
        view.addSubview(titleLabel)
        
        
        let imageViewCenter = UIImageView(frame: CGRectMake(0, 0, SizeUtil.convertIphone6ToIphone5(55), SizeUtil.convertIphone6ToIphone5(55)))
        imageViewCenter.image = UIImage(named:"arrow.png")
        imageViewCenter.center.x = viewWidth/2
        imageViewCenter.center.y = titleLabel.center.y + titleLabel.frame.size.height * 1.3
        view.addSubview(imageViewCenter)
        
        let imageViewLeft = UIImageView(frame: CGRectMake(0, 0, SizeUtil.convertIphone6ToIphone5(55), SizeUtil.convertIphone6ToIphone5(55)))
        imageViewLeft.image = UIImage(named:"currency-icon.png")
        imageViewLeft.center.x = imageViewCenter.center.x - imageViewCenter.frame.size.width
        imageViewLeft.center.y = titleLabel.center.y + titleLabel.frame.size.height * 1.3
        view.addSubview(imageViewLeft)
        
        let imageViewRight = UIImageView(frame: CGRectMake(0, 0, SizeUtil.convertIphone6ToIphone5(110), SizeUtil.convertIphone6ToIphone5(110)))
        imageViewRight.image = UIImage(named:"currency-icon.png")
        imageViewRight.center.x = imageViewCenter.center.x + imageViewCenter.frame.size.width * 1.5
        imageViewRight.center.y = titleLabel.center.y + titleLabel.frame.size.height * 1.3
        view.addSubview(imageViewRight)
        
        return view
        
    }
    
    func getThirdView() -> UIView {
        
        var viewWidth : CGFloat = 0.0
        var viewHeight : CGFloat = 0.0
        
        let view = UIView()
        
        view.frame = CGRectMake(0 , 0,SizeUtil.screenWidth(),scrollView2.frame.size.height)
        view.backgroundColor = UIColor.grayColor()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.grayColor().CGColor
        view.center.x = self.view.frame.size.width/2
        view.center.y = self.view.frame.size.height/2
        
        viewWidth = view.frame.size.width
        viewHeight = view.frame.size.height
        
        
        let titleLabel = UILabel(frame: CGRectMake(0, 0, SizeUtil.convertIphone6ToIphone5(320), SizeUtil.convertIphone6ToIphone5(100)))
        titleLabel.text = "Track the the prices of your properties to see how much your portfolio has made you!"
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 3
        titleLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.center.x = viewWidth/2
        titleLabel.center.y = viewHeight*0 + titleLabel.frame.size.height/2
        view.addSubview(titleLabel)
        
        
        let imageView = UIImageView(frame: CGRectMake(0, 0, SizeUtil.convertIphone6ToIphone5(200), SizeUtil.convertIphone6ToIphone5(200)))
        imageView.image = UIImage(named:"graph-icon.png")
        imageView.center.x = viewWidth/2
        imageView.center.y = titleLabel.center.y + titleLabel.frame.size.height * 1.5
        view.addSubview(imageView)
        
        
        let button = UIButton(frame: CGRectMake(0, 0, SizeUtil.convertIphone6ToIphone5(200), SizeUtil.convertIphone6ToIphone5(50)))
        button.center.x = viewWidth/2
        button.center.y = imageView.center.y + imageView.frame.size.height * 0.60
        button.setTitle("Get Started", forState: UIControlState.Normal)
        button.addTarget(self, action:"removeController", forControlEvents: UIControlEvents.TouchUpInside)
        button.backgroundColor = UIColor.magentaColor()
        view.addSubview(button)
        
        
        return view
        
    }
    
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        
        scrollView2.removeFromSuperview()
        
        scrollView2 = UIScrollView(frame:CGRectMake(0,0,SizeUtil.screenWidth(),SizeUtil.screenHeight()*0.75))
        scrollView2.center.x = SizeUtil.screenWidth()/2
        scrollView2.center.y = SizeUtil.screenHeight()/2
        view.addSubview(scrollView2)
        self.scrollView2.delegate = self
        
        var views:[UIView] = [getFirstView(),getSecondView(),getThirdView()]
        var frame: CGRect = CGRectMake(0, 0, 0, 0)
        
        for index in 0..<views.count {
            
            frame.origin.x = SizeUtil.screenWidth() * CGFloat(index)
            frame.size.width = SizeUtil.screenWidth()
            frame.size.height = scrollView2.frame.size.height
            self.scrollView2.pagingEnabled = true
            
            let subView = views[index]
            subView.frame = frame
            self.scrollView2 .addSubview(subView)
        }
        
        self.scrollView2.contentSize = CGSizeMake(SizeUtil.screenWidth() * CGFloat(views.count),scrollView2.frame.size.height)
    }
    
    func removeController(){
        
    }


}

