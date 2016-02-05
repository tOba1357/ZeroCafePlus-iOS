//
//  EventView2.swift
//  ZeroCafePlus-iOS
//
//  Created by 紺谷和正 on 2016/02/05.
//  Copyright © 2016年 Smartphone.apps.project. All rights reserved.
//

import UIKit

class EventView2: UIView {
    
    private var myImageView: UIImageView!
    
    var mydelegate: EventViewDelegate!
    var myEventID :Int!
    
    init(frame: CGRect, titleNameString: String, id:Int, dateNameString: String, tagNameString: String) {
        super.init(frame: frame)
        myEventID = id
        self.backgroundColor = UIColor.whiteColor()
        self.layer.borderColor = UIColor.hexStr("#1A1A1A", alpha: 1.0).CGColor
        self.layer.borderWidth = 1.3
        
        let dateData = getDateTime(dateNameString)
        let dateText = "\(dateData[1])/\(dateData[2])\n\(dateData[3]):\(dateData[4])~10:00"
        
        let titleName: UILabel = UILabel(frame: CGRectMake(10,60,130,70))
        titleName.numberOfLines = 2
        titleName.textAlignment = NSTextAlignment.Center
        let dateName: UILabel = UILabel(frame: CGRectMake(10,120,130,50))
        dateName.numberOfLines = 2
        dateName.textAlignment = NSTextAlignment.Center
        let tagName: UILabel = UILabel(frame: CGRectMake(10,150,130,70))
        tagName.numberOfLines = 2
        tagName.textAlignment = NSTextAlignment.Center
        let touchButton: UIButton = UIButton(frame: CGRectMake(10,10,130,180))
        
        titleName.text = titleNameString
        dateName.text = dateText
        tagName.text = tagNameString
        
        
        
        touchButton.setTitle("", forState: .Normal)
        touchButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        
        titleName.textColor = UIColor.blackColor()
        
        self.addSubview(titleName)
        self.addSubview(dateName)
        self.addSubview(tagName)
        self.addSubview(touchButton)
        
        
        let myImage = UIImage(named: "party.png")
        myImageView = UIImageView(frame: CGRectMake(0,0,70,70))
        myImageView.image = myImage
        myImageView.layer.position = CGPoint(x: 75, y: 40)
        myImageView.layer.masksToBounds = true
        myImageView.layer.cornerRadius = 10.0
        self.addSubview(myImageView)
    }
    
    func onClickMyButton(sender: UIButton) {
        
        print("success")
        
        self.mydelegate?.pushMyButton(myEventID)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getDateTime(dateTime:String)->[String]{
        let dates:[String] = dateTime.componentsSeparatedByString("T")
        let dateDatas = dates[0].componentsSeparatedByString("-")
        let timeDatas = dates[1].componentsSeparatedByString(":")
        var getDatas = dateDatas
        
        for timeData in timeDatas.enumerate(){
            getDatas.append(timeDatas[timeData.index])
        }
        return getDatas
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}