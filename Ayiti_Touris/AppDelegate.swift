
import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let APP_ID = "2C703DEF-BB5B-08D7-FFDA-6C2620273000"
    let API_KEY = "98AFCACC-DC4E-1460-FF13-D58690CA8200"
    
    var backendless = Backendless.sharedInstance()
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        backendless?.initApp(APP_ID, apiKey:API_KEY)
        print("----------------------------------connected-------------------------------------------")
        // Override point for customization after application launch.
        Parse.initialize(
            with: ParseClientConfiguration(block: { (configuration: ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "Instagram"
                configuration.clientKey = "Instagram21"
                configuration.server = "https://glacial-refuge-81990.herokuapp.com/parse"
            })
        )
                NotificationCenter.default.addObserver(forName: Notification.Name("didLogout"), object: nil, queue: OperationQueue.main) { (Notification) in
                    print("Logout notification received")
                    // TODO: Logout the User
                    // TODO: Load and show the login view controller
                    self.logOut()
                }
       readUser()
        return true
    }
    func readUser(){
        if let currentUser = PFUser.current() {
            let mess = "Welcome back \(currentUser.username!) 😀"
            print(mess)
            // TODO: Load Chat view controller and set as root view controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let ReviewsViewController = storyboard.instantiateViewController(withIdentifier: "ReviewsViewController")
//            window?.rootViewController = ReviewsViewController
        }
    }
    func logOut() {
        // Logout the current user
        PFUser.logOutInBackground(block: { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Successful loggout")
                // Load and show the login view controller
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginViewController")
                self.window?.rootViewController = loginViewController
            }
        })
    }
    
}

