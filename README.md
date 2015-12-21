

## branchの切り方

* 基本的にbranch名はzerocafe-ios-"ユーザ名"-"issue番号"とする。

例...zerocafe-ios-takemoxu-#1

## GET,POSTのやり方

#### GET,POST用(URL)

users - https://zerocafe.herokuapp.com/api/v1/users.json
events - https://zerocafe.herokuapp.com/api/v1/events.json
tickets(参加登録) - https://zerocafe.herokuapp.com/api/v1/tickets.json
category_tag - https://zerocafe.herokuapp.com/api/v1/category-tags.json

#### GET

###### users
        let url = "https://zerocafe.herokuapp.com/api/v1/users"
        Alamofire.request(.GET, url)
            .responseJSON { response in
                debugPrint(response.result.value)
                //ここでswiftyJsonなりで値を料理する
        }

###### evets
        let url = "https://zerocafe.herokuapp.com/api/v1/events"
        Alamofire.request(.GET, url)
            .responseJSON { response in
                debugPrint(response.result.value)
                //ここでswiftyJsonなりで値を料理する
        }

##### POST

###### users

      let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        let parameters:[String:AnyObject] =
        [
            "user": [
                "zerocafe_id": "A12321232123421",
                "name": "まぐろ",
                "password":"123432123421234",
                "description":"githubの活性か",
                "major":"12345"
                ]
        ]
        let url = "https://zerocafe.herokuapp.com/api/v1/users"
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON, headers:headers)
        .responseString { response in
                debugPrint(response.result.value)
                //"いいよぉ！"が返ってくれば成功
        }

###### evets
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        let parameters:[String:AnyObject] =
        [
            "event": [
                "title": "Herokuをたべる",
                "description": "秋を味わう",
                "belonging":"aaaaa",
                "entry_fee": 999999,
                "user_id": 1,
                "dive_join": true,
                "start_time": "2015-12-11 T 12:00",
                "end_time": "2015-12-11 T 20:00",
                "confirm": true,
                "categoly_tag": "hasao",
                "place":"A"
                ]
        ]

        let url = "https://zerocafe.herokuapp.com/api/v1/events"
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON, headers:headers)
            .responseString { response in
                debugPrint(response.result.value)
                //"いいよぉ！"が返って来れば成功
        }
            
