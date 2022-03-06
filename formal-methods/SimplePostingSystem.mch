/* SimplePostingSystem
 * Author: Cristi
 * Creation date: 12/15/2021
 */
MACHINE
    SimplePostingSystem
SEES
    String
INCLUDES
   UserPost, Comment
PROMOTES
    createUser, setUserFName, setUserLName, setUserEmail, setUserMoney, setUserPassword,
    getUserId, getUserFName, getUserLName, getUserEmail, getUserMoney, getUserPassword, 
    removeUser, removePost, setPostAuthor, setPostTitle, setPostText, getPostAuthor, getPostTitle,
    getPostText, getPostLikes, getPostViews, addUserViewAndMoney, addUserLikeAndMoney, createPost,   addNewComment, deletePostComment, getCommId, getCommUser, 
    getCommPost, getCommText, setCommUser, setCommPost, setCommText, deleteAllCommentsOfUser,
    deleteAllCommentFromPost
    
OPERATIONS 
    
   removeUserAccount(userVal) =
   PRE
      userVal : users
   THEN
      deleteAllCommentsOfUser(userVal) ||
      removeUser(userVal)
   END;
   
   removeExistingPost(pstVal) =
   PRE
       pstVal: posts
   THEN
       deleteAllCommentFromPost(pstVal) ||
       removePost(pstVal)
   END;
    
   changePostAuthor(authVal, pstVal) =
   PRE
       pstVal : dom(postAuthor) &
       authVal : users - commentUser[commentPost~[{pstVal}]] - {postAuthor(pstVal)}
       & authVal /: postLikes ( pstVal )
                   & authVal /: postViews ( pstVal )
                   & postTitle ( pstVal ) /: postTitle[postAuthor~[{authVal}]]
   THEN
       setPostAuthor ( pstVal, authVal)
   END;
   
   addCommentToPost(postValue, userVal, txtVal, moneyVal) =
   PRE
        userVal : users & 
        postValue : posts - postAuthor~[{userVal}] &
        txtVal : STR &
        moneyVal: REAL & moneyVal >= 0.0
   THEN
       addNewComment(userVal, postValue, txtVal) ||
       setUserMoney(postAuthor(postValue), userMoney(postAuthor(postValue))+moneyVal)
   END
END
