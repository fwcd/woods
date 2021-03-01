//
//  LoginView.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    let onLogIn: (Account) -> Void
    
    @State private var credentials: Credentials = Credentials()
    @State private var accountType: AccountType = .geocachingCom // TODO
    
    var body: some View {
        Form {
            Section(header: Text("Account Type")) {
                EnumPicker(selection: $accountType, label: Text("Account Type"))
            }
            Section(header: Text("Credentials")) {
                TextField("Username", text: $credentials.username)
                SecureField("Password", text: $credentials.password)
            }
            Button(action: {
                onLogIn(Account(type: accountType, credentials: credentials))
            }) {
                Text("Log in")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    @State static var credentials = Credentials()
    static var previews: some View {
        LoginView { _ in }
    }
}
