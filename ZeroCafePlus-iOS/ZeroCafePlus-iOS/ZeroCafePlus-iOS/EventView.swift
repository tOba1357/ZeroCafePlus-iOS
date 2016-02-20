//
//  EventView.swift
//  ZeroCafePlus-iOS
//
//  Created by Kento Takemoto on 2016/02/05.
//  Copyright © 2016年 Smartphone.apps.project. All rights reserved.
//

import Foundation

class EventView :UIView{
    
    private var genreImageView: UIImageView!
    private var genreImage: UIImage!
    
    var mydelegate: EventViewDelegate!
    var myEventID :Int!
    
    init(frame: CGRect, titleNameString: String, id:Int, startDateString: String, endDateString: String,tagNameString: String, genreImageNum: Int) {
        super.init(frame: frame)
        myEventID = id
        
        self.backgroundColor = UIColor.whiteColor()
        
        let screenSize: CGSize = UIScreen.mainScreen().bounds.size
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let startData = getDateTime(startDateString)
        let endData = getDateTime(endDateString)
        let dateText = "\(startData[1])/\(startData[2])\n\(startData[3]):\(startData[4])~\(endData[1])/\(endData[2])\n\(endData[3]):\(endData[4])"
        
        let titleName: UILabel = UILabel(frame: CGRectMake(10,60,130,70))
        titleName.numberOfLines = 2
        titleName.textAlignment = NSTextAlignment.Center
        let dateName: UILabel = UILabel(frame: CGRectMake(10,110,130,50))
        dateName.numberOfLines = 2
        dateName.textAlignment = NSTextAlignment.Center
        let tagName: UILabel = UILabel(frame: CGRectMake(10,140,130,70))
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
        
        if genreImageNum == 0 {
            genreImage =  CommonFunction().resizingImage(imageName: "jobhunt.png", w: 70, h: 70)
            
            
        } else if genreImageNum == 1 {
            genreImage =  CommonFunction().resizingImage(imageName: "study.png", w: 70, h: 70)
            
        } else if genreImageNum == 2 {
            genreImage =  CommonFunction().resizingImage(imageName: "party.png", w: 70, h: 70)
            
        } else if genreImageNum == 3 {
            genreImage =  CommonFunction().resizingImage(imageName: "circle.png", w: 70, h: 70)
            
        } else if genreImageNum == 4 {
            genreImage =  CommonFunction().resizingImage(imageName: "tournament.png", w: 70, h: 70)
            
        } else if genreImageNum == 5 {
            genreImage =  CommonFunction().resizingImage(imageName: "hobby.png", w: 70, h: 70)
            
        } else if genreImageNum == 6 {
            genreImage =  CommonFunction().resizingImage(imageName: "readbook.png", w: 70, h: 70)
            
        }
        
        
//        let genreImage = UIImage(named: "party.png")
        genreImageView = UIImageView(frame: CGRectMake(0,0,70,70))
        genreImageView.image = genreImage
        genreImageView.layer.position = CGPoint(x: 75, y: 40)
        genreImageView.layer.masksToBounds = true
        genreImageView.layer.cornerRadius = 10.0
        self.addSubview(genreImageView)
        
        
        
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
    
}



