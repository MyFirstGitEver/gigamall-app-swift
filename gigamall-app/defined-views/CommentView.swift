//
//  CommentView.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 15/08/2023.
//

import SwiftUI

struct CommentView: View {
    let commentBgColor = Color(
        red: 65 / 255,
        green: 169 / 255,
        blue: 239 / 255)
    
    let comment : Comment
    
    @State private var subCommentsCount : Int = 0
    @State private var subComments : [Comment] = []
    
    @State private var containsMore: Bool = true
    
    var body: some View {
        VStack {
            mainPartOfComment
            
            if subComments.count != 0 {
                LazyVStack {
                    ForEach(subComments) { comment in
                        CommentView(comment: comment)
                    }
                }
            }
            
            HStack {
                if containsMore && comment.childCount != 0 {
                    Button(action: {
                        CommentAPICaller.instance.getRepliesOfComment(
                            replyId: comment.commentId,
                            page: subCommentsCount,
                            onComplete: { result in
                                withAnimation(.spring()) {
                                    processSubCommentsResult(result: result)
                                }
                            })
                    }) {
                        Text("Xêm thêm \(comment.childCount) phản hồi")
                    }
                    .padding([.leading], 10)
                }
                Spacer()
            }
        }.padding([.leading], CGFloat(comment.level) * 20)
    }
    
    var mainPartOfComment : some View {
        HStack{
            AsyncImage(url: URL(string: comment.attatchedUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
            } placeholder: {
                Color.gray
            }
            .frame(width: 60, height: 60)
            .cornerRadius(30)
            
            VStack(alignment: .leading){
                Text(comment.userDisplayName)
                Text("\(comment.contentInStar) 🌟")
            }.padding([.trailing], 10)
            
            VStack {
                Text(comment.contentInText)
                    .padding(10)
                    .background(commentBgColor)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                HStack {
                    Spacer()
                    Text(MyDateFormatter.diffFromNow(date: comment.sentDate))
                        .bold()
                        .padding([.trailing], 15)
                }
            }
        }
    }
    
    func processSubCommentsResult(result: Result<[CommentEntity], Error>) {
        do {
            let newSubComments = try result.get()
            
            if newSubComments.count == 0 {
                containsMore = false
                return
            }
            
            self.subComments.append(
                contentsOf: newSubComments.map( { Comment(entity: $0) } ))
            subCommentsCount += 1
        }
        catch let err {
            print(err.localizedDescription)
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(comment:Comment(
                            attatchedUrl: "https://res.cloudinary.com/dk8hbcln1/image/upload/v1672655936/meo4_bke2pl.jpg",
                            level: 0))
    }
}
