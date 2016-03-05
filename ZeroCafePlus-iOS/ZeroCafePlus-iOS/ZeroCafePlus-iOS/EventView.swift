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
    var titleName: UILabel!
    var dateName: UILabel!
    var tagName:UILabel!
    var touchButton:UIButton!
    var mydelegate: EventViewDelegate!
    var myEventID :Int!
    
    init(frame: CGRect, titleNameString: String, id:Int, startDateString: String, endDateString: String,tagNameString: String, genreImageNum: Int) {
        super.init(frame: frame)
        
        myEventID = id
        self.backgroundColor = UIColor.whiteColor()
        self.layer.borderColor = UIColor.hexStr("#BABABA", alpha: 1.0).CGColor
        self.layer.borderWidth = 0.9
        
        let weekdays: Array  = ["閏","日", "月", "火", "水", "木", "金", "土"]
        let startData = getDateTime(startDateString)
        let endData = getDateTime(endDateString)
        let weekDay = CommonFunction().getWeekDay(Int(startData[0])!,month: Int(startData[1])!,day: Int(startData[2])!)
        let dateText = "\(startData[1])/\(startData[2])(\(weekdays[weekDay]))\n\(startData[3]):\(startData[4])~\(endData[3]):\(endData[4])"
        
        titleName = UILabel(frame: CGRectMake(0,0,self.frame.width*(266/300),self.frame.height*(120/335)))
        titleName.text = titleNameString
        titleName.numberOfLines = 2
        titleName.sizeToFit()
        titleName.layer.position = CGPoint(x: self.frame.width/2, y: self.frame.height*(140/335))
        titleName.font = UIFont.systemFontOfSize(15)
        titleName.textAlignment = NSTextAlignment.Center
        
        dateName = UILabel(frame: CGRectMake(0,0,self.frame.width*(200/300),self.frame.height*(20/335)))
        dateName.text = dateText
        dateName.numberOfLines = 2
        dateName.textAlignment = NSTextAlignment.Center
        dateName.font = UIFont.systemFontOfSize(12)
        dateName.sizeToFit()
        dateName.layer.position = CGPoint(x: self.frame.width/2, y: self.frame.height*(220/335))
        
        tagName = UILabel(frame: CGRectMake(0,0,130,70))
        tagName.text = tagNameString
        tagName.numberOfLines = 2
        tagName.textAlignment = NSTextAlignment.Justified
        tagName.font = UIFont.systemFontOfSize(12)
        tagName.sizeToFit()
        tagName.layer.position = CGPoint(x: self.frame.width/2, y: self.frame.height*(295/335))
        
        touchButton = UIButton(frame: CGRectMake(self.frame.width*(17/300),10,130,180))
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
        
        genreImageView = UIImageView(frame: CGRectMake(0,0,self.frame.width*(76/300),self.frame.height*(76/335)))
        genreImageView.image = genreImage
        genreImageView.layer.position = CGPoint(x: self.frame.width/2, y: self.frame.height*(64/335))
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



