/* UserPost
 * Author: Cristi
 * Creation date: 12/12/2021
 */
MACHINE
    UserPost
SEES
    String
INCLUDES
    User, Post
PROMOTES
    createUser, setUserFName, setUserLName, setUserEmail, setUserMoney, setUserPassword,
    getUserId, getUserFName, getUserLName, getUserEmail, getUserMoney, getUserPassword, 
    disableUser, setPostAuthor, setPostTitle, setPostText, getPostAuthor, getPostTitle,
    getPostText, getPostLikes, getPostViews, addPostView, addPostLike, createPost, removePost, removeAllUserPosts
OPERATIONS
    removeUser ( userValue ) =
    PRE
        userValue : users
    THEN
        removeAllUserPosts(userValue) ||
        disableUser(userValue)
    END;
    
    addUserLikeAndMoney(postValue, userVal, moneyVal) =
    PRE
        postValue : posts &
        userVal : users &
        moneyVal: REAL & moneyVal>=0.0 &
            userMoney(postAuthor(postValue)) + moneyVal >= 0.0 &
            postAuthor(postValue) /= userVal
    THEN
        addPostLike(postValue, userVal) ||
        setUserMoney(userVal, userMoney(postAuthor(postValue)) + moneyVal)
    END;
    
    addUserViewAndMoney(postValue, userVal, moneyVal) =
    PRE
        postValue : posts &
        userVal : users &
        moneyVal: REAL & moneyVal>=0.0 &
            userMoney(postAuthor(postValue)) + moneyVal >= 0.0 &
            postAuthor(postValue) /= userVal
    THEN
        addPostView(postValue, userVal) ||
        setUserMoney(userVal, userMoney(postAuthor(postValue))+moneyVal)
    END  
END
