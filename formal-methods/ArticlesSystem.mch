/* ArticlesSystem
 * Author: Cristi
 * Creation date: 12/15/2021
 */
MACHINE
    ArticlesSystem
INCLUDES RewardSystem
PROMOTES
createUser, setUserFName, setUserLName, setUserEmail, setUserMoney, setUserPassword,
    getUserId, getUserFName, getUserLName, getUserEmail, getUserMoney, getUserPassword, 
    deleteExistingUser, deleteExistingPost, changePostAuthor, setPostTitle, setPostText, getPostAuthor, getPostTitle,
    getPostText, getPostLikes, getPostViews, addViewToPost, addLikeToPost, createPost, addUserCommentToPost, addCommentToPost, deletePostComment, getCommId, getCommUser, 
    getCommPost, getCommText, setCommUser, setCommPost, setCommText, deleteAllCommentsOfUser,
    deleteAllCommentFromPost, createCompany, removeCompany, setCompanyName, setCompanyEmail,
    setCompanyPhoneNo, setCompanyWebsite, getCompanyName, getCompanyEmail, getCompanyPhone,
    getCompanyWebsite, newSponsorship, removeSponsorship, getSponsorshipId, getSponsoredPost,
    getSponsor, getLikeVal, getViewVal, getComentVal, setPost, setCompany, setLikes, 
    setComment, setView, removeAllSponsorshipsOfACompany, removePostSponsorships,
    removeAllSponsosrshipsFromPosts 
END
