//
//  AccountLoginSnippetView.swift
//  Woods
//
//  Created by Fredrik on 14.04.22.
//

import SwiftUI

struct AccountLoginSnippetView: View {
    let login: AccountLogin
    
    var body: some View {
        Label {
            AccountSnippetView(account: login.account)
        } icon: {
            AccountLoginStateView(state: login.state)
        }
    }
}

struct AccountLoginSnippetView_Previews: PreviewProvider {
    static var previews: some View {
        AccountLoginSnippetView(login: AccountLogin(
            account: Account(
                id: UUID(uuidString: "b0819a69-ceef-4323-b752-ff09a70230fd")!,
                type: .mock,
                credentials: Credentials(
                    username: "test",
                    password: "test"
                )
            ),
            state: .connecting
        ))
    }
}
