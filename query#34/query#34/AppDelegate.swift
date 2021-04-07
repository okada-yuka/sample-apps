//
//  AppDelegate.swift
//  query#34
//
//  Created by Yuka Okada on 2021/04/07.
//

import UIKit
import AWSCognitoIdentityProvider
import AWSCore
import AWSAppSync
import AWSMobileClient


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appSyncClient: AWSAppSyncClient?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let accessKey = IAMConstans.accessKey
        let secretKey = IAMConstans.secretKey
        let provider = AWSStaticCredentialsProvider(accessKey: accessKey, secretKey: secretKey)

        let configuration = AWSServiceConfiguration(
            region: AWSRegionType.APNortheast1,  // regionは適宜変更してください
            credentialsProvider: provider)

        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        // AppSyncの初期設定
        do {
            
            // You can choose the directory in which AppSync stores its persistent cache databases
            let cacheConfiguration = try AWSAppSyncCacheConfiguration()
            
            // Initialize the AWS AppSync configuration
            let appSyncServiceConfig = try AWSAppSyncServiceConfig()
            let appSyncConfig = try AWSAppSyncClientConfiguration(appSyncServiceConfig: appSyncServiceConfig, cacheConfiguration: cacheConfiguration)
            
            // Initialize the AWS AppSync client
            appSyncClient = try AWSAppSyncClient(appSyncConfig: appSyncConfig)
            
            // Set id as the cache key for objects. See architecture section for details
            appSyncClient?.apolloClient?.cacheKeyForObject = { $0["id"] }
            
            print("Initialized appsync client.")
            
        } catch {
            print("Error initializing appsync client. \(error)")
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

