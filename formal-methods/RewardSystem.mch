/* RewardSystem
 * Author: Cristi
 * Creation date: 12/15/2021
 */
MACHINE
    RewardSystem
SEES
    String
INCLUDES
    SimplePostingSystem, Sponsorship, Company

PROMOTES
    createUser, setUserFName, setUserLName, setUserEmail, setUserMoney, setUserPassword,
    getUserId, getUserFName, getUserLName, getUserEmail, getUserMoney, getUserPassword, 
    removeUserAccount, removeExistingPost, changePostAuthor, setPostTitle, setPostText, getPostAuthor, getPostTitle,
    getPostText, getPostLikes, getPostViews, addUserViewAndMoney, addUserLikeAndMoney, createPost, addCommentToPost, deletePostComment, getCommId, getCommUser, 
    getCommPost, getCommText, setCommUser, setCommPost, setCommText, deleteAllCommentsOfUser,
    deleteAllCommentFromPost, createCompany, deleteCompany, setCompanyName, setCompanyEmail,
    setCompanyPhoneNo, setCompanyWebsite, getCompanyName, getCompanyEmail, getCompanyPhone,
    getCompanyWebsite, newSponsorship, removeSponsorship, getSponsorshipId, getSponsoredPost,
    getSponsor, getLikeVal, getViewVal, getComentVal, setPost, setCompany, setLikes, 
    setComment, setView, removeAllSponsorshipsOfACompany, removePostSponsorships,
    removeAllSponsosrshipsFromPosts
OPERATIONS
    removeCompany(compVal) =
    PRE
        compVal : companies
    THEN
        removeAllSponsorshipsOfACompany(compVal) ||
        deleteCompany(compVal) 
    END;
    
    deleteExistingPost(pstVal) = 
    PRE
        pstVal : posts
    THEN
        removePostSponsorships(pstVal) ||
        removeExistingPost(pstVal)
    END;
    
    deleteExistingUser(usrVal) =
    PRE
        usrVal : users
    THEN
        removeAllSponsosrshipsFromPosts(postAuthor~[{usrVal}]) ||
        removeUserAccount(usrVal)
    END;
    
    addLikeToPost(postValue, userVal) =
    PRE
         postValue : posts &
         userVal : users & postAuthor ( postValue ) /= userVal
    THEN
        addUserLikeAndMoney(postValue, userVal, SIGMA(xx).(xx: like[post~[{postValue}]] | 0.0))
    END;
    
    addViewToPost(postValue, userVal) =
    PRE
        postValue: posts &
        userVal : users &
            postAuthor(postValue) /= userVal
    THEN
        addUserViewAndMoney(postValue, userVal, SIGMA(xx).(xx: view[post~[{postValue}]] | 0.0))
    END;
    
    addUserCommentToPost(postValue, userVal, txtVal) =
    PRE
       postValue: posts &
       userVal: users &
       txtVal: STR &
           postAuthor(postValue) /= userVal
   THEN
       addCommentToPost(postValue, userVal, txtVal, SIGMA(xx).(xx: comment[post~[{postValue}]]|0.0))
   END
END
