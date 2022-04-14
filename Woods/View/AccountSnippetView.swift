//
//  AccountSnippetView.swift
//  Woods
//
//  Created by Fredrik on 14.04.22.
//

import SwiftUI

struct AccountSnippetView: View {
    let account: Account
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(account.type.description)
                .font(.headline)
            Text(account.credentials.username)
                .font(.subheadline)
        }
    }
}

struct AccountSnippetView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSnippetView(account: Account(
            id: UUID(uuidString: "b0819a69-ceef-4323-b752-ff09a70230fd")!,
            type: .mock,
            credentials: Credentials(
                username: "test",
                password: "test"
            )
        ))
    }
}
