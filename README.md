

## branchの切り方

* 基本的にbranch名はzerocafe-ios-"ユーザ名"-"issue番号"とする。

例...zerocafe-ios-takemoxu-#1

# GET

###users
        let url = "https://zerocafe.herokuapp.com/api/v1/users"

        Alamofire.request(.GET, url)
            .responseJSON { response in
                debugPrint(response.result.value)
                //ここで
        }





# POST
### users

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
                debugPrint(response.result.value!)
                //いいよぉ！が返ってくれば成功
        }

### evets
            
