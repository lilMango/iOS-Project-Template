//
//  NetworkError.swift
//  Project-Template
//
//  Created by Miguel Paysan on 7/5/21.
//

import SwiftUI

struct NetworkErrorView: View {
    typealias ErrorViewActionHandler = () -> Void
    
    let error: Error
    let handler: ErrorViewActionHandler
    
    internal init(error: Error,
                  handler: @escaping NetworkErrorView.ErrorViewActionHandler) {
        self.error = error
        self.handler = handler
    }
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.icloud.fill")
                .foregroundColor(.gray)
                .font(.system(size: 30, weight: .heavy))
                .multilineTextAlignment(.center)
                .padding(.vertical, 4)
            Text("Oops!")
                .foregroundColor(.black)
                .font(.system(size: 30, weight: .heavy))
                .multilineTextAlignment(.center)
            Text(error.localizedDescription)
            Button(action: {
                handler()
            }, label: {
                Text("Retry")
            })
            .padding(.vertical, 12)
            .padding(.horizontal, 30)
            
        }
    }
}


struct ErroView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkErrorView(error: APIError.decodingError, handler: {})
            .previewLayout(.sizeThatFits)
    }
}
