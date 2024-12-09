//
//  FireAuth.swift
//  MyTodoList
//
//  Created by Lucas Newlands on 29/11/24.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import Firebase

struct FireAuth {
    static let share = FireAuth()
    
    private init() { }
    
    func signInWithGoogle(presenting: UIViewController, completion: @escaping(Error?) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: presenting) { result, error in
            guard error == nil else {
                completion(error)
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                guard error == nil else {
                    // MARK: - Manage Error
                    //
                    return
                }
                print("logado!")
                UserDefaults.standard.set(true, forKey: "signIn")
            }
        }
    }
    
    func SignOut(presenting: UIViewController, completion: @escaping(Error?) -> Void) {
        do {
             try Auth.auth().signOut()
            UserDefaults.standard.set(false, forKey: "signIn")
        } catch {
            guard error == nil else {
                completion(error)
                return
            }
        }
    }
}
