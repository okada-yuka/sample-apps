//
//  ViewController.swift
//  query#34
//
//  Created by Yuka Okada on 2021/04/07.
//

import UIKit
import AWSAppSync
import AWSMobileClient
import AWSDynamoDB


class ViewController: UIViewController {
    
    var appSyncClient: AWSAppSyncClient?
    
    var username: String = "u1"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appSyncClient = appDelegate.appSyncClient
        
        //fetchDynamoDBData()
    }
    
    


    
    // DynamoDBからデータを取得する（scan）
    func fetchDynamoDBData(){
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
        let scanExpression = AWSDynamoDBScanExpression()
        
        dynamoDBObjectMapper.scan(User.self, expression: scanExpression).continueWith(){ (task: AWSTask<AWSDynamoDBPaginatedOutput>!) -> Void in
            guard let items = task.result?.items as? [User] else {return}
            if let error = task.error as NSError?{
                print("The request failed. Error: \(error)")
                return
            }
            print(items[0].id)
            print(items.count)
            
            for index in 0 ..< items.count{
                if items[index].id == "test-id-4"{
                    print(items[index].username)
                }
            }
        }
    
    }
    
    
    // DynamoDBにデータを追加する
    func runMutation(){
        
        // CreateToDoInput関数：入力パラメータを作成
        
        //let mutationInput = CreateMealInput(userId: "test-id", day: "date", timing: "lunch", cal: 9)
        let mutationInput = CreateUserInput(id: "test-id-5", username: "test-username-5555", star: 1)
        //let mutationInput = CreateWeightInput(userId: <#T##String#>, day: <#T##String#>, weight: <#T##Int#>)
        //userId: String("userID2"), day: String("date"), weight: Int(1))
            //weightId: "test", createdBy: "appDelegate.username", day: "date", weight: 3)

        // CreateTodoMutation関数：
        // AppSyncのcreateTodoに設定されているresolverを実行し，DynamoDBにデータを追加する
        appSyncClient?.perform(mutation: CreateUserMutation(input: mutationInput)) { (result, error) in

            if let error = error as? AWSAppSyncClientError {
                print("Error occurred: \(error.localizedDescription )")
            }
            
            // MealとWeightの時にこのエラーになる
            // 一応追加はできているのでとりあえず無視する
//            if let resultError = result?.errors{
//                print("Error saving the item on server: \(resultError)")
//                return
//            }
            
            print("データを追加（runMutation）")

        }
        
    }
    @IBAction func fetchData(_ sender: Any) {
        
//        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
//        let queryExpression = AWSDynamoDBQueryExpression()
//
//        queryExpression.keyConditionExpression = "#bigCompany = :bigCompany"
//                    queryExpression.expressionAttributeNames = ["#bigCompany": "bigCompany",]
//                    queryExpression.expressionAttributeValues = [":bigCompany" : self.username,]
//
//                    dynamoDBObjectMapper.query(User.self, expression: queryExpression).continue(with: AWSExecutor.immediate(), with: { (task:AWSTask!) -> AnyObject! in
//                        //If added successfully
//                        if((task.result) != nil) {
//                            let results = task.result! as AWSDynamoDBPaginatedOutput
//                            print(results.items)
//                        }
//                        else {
//                            //do error checking here
//                        }
//                    })
        
        
//        let queryExpression = AWSDynamoDBQueryExpression()
//                queryExpression.keyConditionExpression = "username = :u1"
//                queryExpression.expressionAttributeValues = [":u1" : "u1"]
//
//        dynamoDBObjectMapper.query(User.self, expression: queryExpression).continueWith(executor: AWSExecutor.mainThread(), block: {(task:AWSTask!) -> AnyObject? in
//                    let results = task.result as! AWSDynamoDBPaginatedOutput
//                    for r in results.items{
//                        print (r)
//                    }
//                    return nil
//                })
//
        
        /*
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
        let queryExpression = AWSDynamoDBQueryExpression()
        let user = User()
        user?.id = "3456789012"
        user?.username = "The Scarlet Letter"
        user?.star = 32
        user?.goal = "899"

        
        dynamoDBObjectMapper.query(User.self, expression: queryExpression).continueWith(){ (task: AWSTask<AWSDynamoDBPaginatedOutput>!) -> Void in
        //dynamoDBObjectMapper.query(User.self, expression: queryExpression).continueWith(){ (task: AWSTask<AWSDynamoDBPaginatedOutput>!) -> Void in
        //dynamoDBObjectMapper.save(user!).continueWith()({ (task: AWSTask<AWSDynamoDBPaginatedOutput>!) -> Void in
        //continue({ (task: AWSTask<AnyObject>) -> Any? in
            if let error = task.error as? NSError {
                print("The request failed. Error: \(error)")
            } else {
                print("The request successed")
            }


        }
        */
        fetchDynamoDBData()
    }
    
    @IBAction func pushDataToDynamo(_ sender: Any) {
        runMutation()
        
    }
    
}

