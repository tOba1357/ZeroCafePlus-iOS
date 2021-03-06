//
//  CommonFunction.swift
//  ZeroCafePlus-iOS
//
//  Created by Shohei_Hayashi on 2016/02/03.
//  Copyright © 2016年 Smartphone.apps.project. All rights reserved.
//

import UIKit

class CommonFunction: AnyObject {
    
    // imageName = "aaa:png", w or h : CGFloat
    func resizingImage(imageName imageName :String, w:CGFloat, h:CGFloat) ->UIImage
    {
        let image = UIImage(named: "\(imageName)")
        let size = CGSize(width: w, height: h)
        UIGraphicsBeginImageContext(size)
        image!.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizeImage
    }
    
    //月の最終日の取得
    func getLastDay(var year:Int,var month:Int) -> Int?{
        let dateFormatter:NSDateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "yyyy/MM/dd";
        if month == 12 {
            month = 0
            year++
        }
        let targetDate:NSDate? = dateFormatter.dateFromString(String(format:"%04d/%02d/01",year,month+1));
        if targetDate != nil {
            //To calculate the one day before from the beginning of the month, get the date of the end of the month
            let orgDate = NSDate(timeInterval:(24*60*60)*(-1), sinceDate: targetDate!)
            let str:String = dateFormatter.stringFromDate(orgDate)
            return Int((str as NSString).lastPathComponent);
        }
        
        return nil;
    }
    
    
    //第何週の取得
    func getWeek(year:Int,month:Int,day:Int) ->Int{
        let dateFormatter:NSDateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "yyyy/MM/dd";
        let date:NSDate? = dateFormatter.dateFromString(String(format:"%04d/%02d/%02d",year,month,day));
        if date != nil {
            let calendar:NSCalendar = NSCalendar.currentCalendar()
            let dateComp:NSDateComponents = calendar.components(NSCalendarUnit.WeekOfMonth, fromDate: date!)
            return dateComp.weekOfMonth;
        }
        return 0;
    }
    
    //曜日の取得
    func getWeekDay(year:Int,month:Int,day:Int) ->Int{
        let dateFormatter:NSDateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "yyyy/MM/dd";
        let date:NSDate? = dateFormatter.dateFromString(String(format:"%04d/%02d/%02d",year,month,day));
        if date != nil {
            let calendar:NSCalendar = NSCalendar.currentCalendar()
            let dateComp:NSDateComponents = calendar.components(NSCalendarUnit.Weekday, fromDate: date!)
            return dateComp.weekday;
        }
        return 0
    }
    
    func nowDateData() -> [String]{
        let dateFormatter:NSDateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "yyyy/MM/dd";
        let dateString:String = dateFormatter.stringFromDate(NSDate());
        let dates:[String] = dateString.componentsSeparatedByString("/")
        
        return dates
    }
    
    func genreImage(genreId genreId:Int,width:CGFloat,height:CGFloat)->UIImage{
        var gImg = UIImage()
        switch genreId{
        case 1:
            gImg = resizingImage(imageName: "study.png", w: width, h:height)
        case 2:
            gImg = resizingImage(imageName: "party.png", w: width, h:height)
        case 3:
            gImg = resizingImage(imageName: "circle.png", w: width, h:height)
        case 4:
            gImg = resizingImage(imageName: "tournament.png", w: width, h:height)
        case 5:
            gImg = resizingImage(imageName: "hobby.png", w: width, h:height)
        case 6:
            gImg = resizingImage(imageName: "readbook.png", w: width, h:height)
        case 7:
            gImg = resizingImage(imageName: "jobhunt.png", w: width, h:height)

        default:
            break
        }
        return gImg
    }
    


}
