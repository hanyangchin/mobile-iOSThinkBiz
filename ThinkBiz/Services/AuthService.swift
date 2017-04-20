//
//  AuthService.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 19/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import FirebaseAuth
import SwiftKeychainWrapper

final class AuthService : AuthServiceProtocol {
    
    // MARK: - Shared Instance
    static let sharedInstance: AuthService = AuthService()
    
    // Singleton
    private init() { }
    
    // MARK: - AuthServiceProtocol
    
    func signIn(withEmail email: String, password: String, completion:((_ errorDescription: String?) -> Void)?) -> Void {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
            if error != nil {
                var errorMessage: String
                
                // TODO: May need to handle certain conditions
//                print(error.debugDescription)
//                if let errorCode = FIRAuthErrorCode(rawValue: error!._code) {
//                    switch errorCode {
//                    case .errorCodeInvalidEmail:
//                        errorMessage = "Invalid email"
//                    case .errorCodeNetworkError:
//                        errorMessage = "Network error. Please try again"
//                    case .errorCodeWrongPassword:
//                        errorMessage = "Sorry, wrong password"
//                    case .errorCodeUserNotFound:
//                        errorMessage = "Login does not exists"
//                    default:
//                        errorMessage = "Unknown error occurred"
//                    }
//                }
                
                errorMessage = error?.localizedDescription ?? "Unknown error occurred"
                completion?(errorMessage)
            } else {
                print("Email user authenticated with Firebase")
                if let user = user {
                    let userData = ["provider": user.providerID]
                    self.completeSignIn(id: user.uid, userData: userData)
                    completion?(nil)
                } else {
                    completion?("Failed to sign in.")
                }
            }
        })
    }
    
    func signUp(withEmail email: String, password: String, completion:((_ errorDescription: String?) -> Void)?) -> Void {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
            if error != nil {
                var errorMessage: String
                
                // TODO: May need to handle certain conditions
//                print(error.debugDescription)
//                if let errorCode = FIRAuthErrorCode(rawValue: error!._code) {
//                    switch errorCode {
//                    case .errorCodeInvalidEmail:
//                        errorMessage = "Invalid email"
//                    case .errorCodeWeakPassword:
//                        errorMessage = "Password should be at least 6 characters"
//                    case .errorCodeNetworkError:
//                        errorMessage = "Network error. Please try again"
//                    case .errorCodeEmailAlreadyInUse:
//                        errorMessage = "Email already been used"
//                    default:
//                        errorMessage = error?.localizedDescription ?? "Error occurred"
//                    }
//                }

                errorMessage = error?.localizedDescription ?? "Unknown error occurred"
                completion?(errorMessage)
            } else {
                if let user = user {
                    let userData = ["provider": user.providerID]
                    self.completeSignIn(id: user.uid, userData: userData)
                    completion?(nil)
                } else {
                    completion?("Failed to sign up.")
                }
            }
        })
    }
    
    private func completeSignIn(id: String, userData: Dictionary<String, String>) -> Void {
        ApiService.sharedInstance.createFirebaseDBUser(uid: id, userData: userData)

        let keyChainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("Data saved to keychain \(keyChainResult) with ID \(id)")
    }
    
    func signOut(completion:((_ errorDescription: String?) -> Void)?) -> Void {
        // Signout of Firebase
        do {
            try FIRAuth.auth()?.signOut()
            // Remove UID from Keychain
            let keyChainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
            print("Keychain result \(keyChainResult)")
            
            completion?(nil)
        } catch {
            completion?("Error signing out")
        }
    }
}

protocol AuthServiceProtocol {
    func signUp(withEmail email: String, password: String, completion:((_ errorDescription: String?) -> Void)?) -> Void
    func signIn(withEmail email: String, password: String, completion:((_ errorDescription: String?) -> Void)?) -> Void
    func signOut(completion:((_ errorDescription: String?) -> Void)?) -> Void
}
