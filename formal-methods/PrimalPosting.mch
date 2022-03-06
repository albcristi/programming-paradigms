/* Primal Posting
 * We use this in order to enable users
 * to add comments to their posts. In this
 * way we make a stronger connection between Users
 * and posts by means of enabling the mechanism of
 * post comments
 */
 
MACHINE
    Comment
SEES
    String
INCLUDES
    UserPost
SETS
    COMMENT
VARIABLES
    comments,
    commentId,
    commentUser,
    commentPost,
    commentText
INVARIANT
    comments <: COMMENT &
    commentId : comments >-> NATURAL1 &
    commentUser : comments --> users &
    commentPost : comments --> posts &
    commentText : comments --> STR &
    /*An author can not add comments to his/hers articles*/
   ! comm . ( comm : comments => userId ( commentUser ( comm ) ) /= userId ( postAuthor ( commentPost (comm ))))
   // a user can not post multiple times the same comment that he made at a post
   & ! cc . ( cc : comments => ! cs . ( cs : commentUser~[{commentUser(cc)}] - {cc} & postId ( commentPost (cc)) = postId(commentPost(cs)) => commentText(cc) /= commentText(cs)))
INITIALISATION
    comments,
    commentId,
    commentUser,
    commentPost,
    commentText := {}, {}, {}, {}, {}
PROMOTES
    createUser, setUserFName, setUserLName, setUserEmail, setUserMoney, setUserPassword, getUserId,
    getUserFName, getUserLName, getUserEmail, getUserMoney, getUserPassword,
    setPostAuthor, setPostTitle, setPostText, getPostAuthor, getPostTitle, getPostText, 
    getPostLikes, getPostViews, addPostView, addPostLike, createPost, removePost, removeUser
OPERATIONS
    /* new operations that enable the comment mechanism */
    newComment <-- createComment ( usr, pst, txt ) =
    PRE
        usr : users &
        pst : posts &
        txt : STR &
            userId(usr) /= userId(postAuthor(pst))&
        //the user has no other comments with TXT on PST
           ! cc . ( cc : commentUser~[{usr}] & postId (commentPost ( cc ) ) = postId(pst)
               => commentText(cc) /= txt)
    THEN
        ANY comm 
        WHERE comm : PRIMALPOSTING - comments
        THEN
            comments := comments \/ { comm } ||
            ANY idValue 
            WHERE idValue : NATURAL1 & idValue /: ran ( commentId )
            THEN
                commentId ( comm ) := idValue
            END ||
            commentUser ( comm ) := usr ||
            commentPost ( comm ) := pst ||
            commentText ( comm ) := txt ||
            newComment := comm
        END
    END;
    
    deletePostComment ( commValue ) =
    PRE
        commValue : comments
    THEN
        comments := comments - { commValue } ||
        commentUser := { commValue } <<| commentUser ||
        commentPost := { commValue } <<| commentPost ||
        commentText := { commValue } <<| commentText ||
        commentId := { commValue } <<| commentId
    END;
    
    commIdVal <-- getCommId ( commVal ) =
    PRE
        commVal : comments
    THEN
        commIdVal := commentId ( commVal )
    END;
    
    commUserVal <-- getCommUser ( commVal ) =
    PRE
       commVal : comments
    THEN
        commUserVal := commentUser ( commVal )
    END;
    
    commUserPost <-- getCommPost ( commVal ) =
    PRE
        commVal : comments
    THEN
        commUserPost := commentPost ( commVal )
    END;
    
    commTextVal <-- getCommText ( commVal ) =
    PRE
        commVal : comments
    THEN
        commTextVal := commentText ( commVal )
    END;
    
 
    setCommUser ( commVal , usrVal ) =
    PRE
        commVal : comments &
        usrVal : users &
           usrVal /= postAuthor ( commentPost ( commVal ))
           // make sure commentText(commVal) is not present on other comments from usrVal on the post
           & ! cc . ( cc : commentUser~[{usrVal}] & commentPost(cc)=commentPost(commVal) => commentText(cc) /= commentText(commVal))
    THEN
        commentUser ( commVal ) := usrVal
    END;
    
    setCommPost ( commVal , pstVal ) =
    PRE
        commVal : comments &
        pstVal : posts &
            commentUser ( commVal ) /=  postAuthor ( pstVal ) 
            // make sure that commentText(commVal) not in any other comments of PSTVAL from commVal usr
            & ! cc . ( cc : commentUser~[{commentUser(commVal)}] & commentPost(cc) = pstVal => commentText(cc) /= commentText(commVal))
    THEN
        commentPost ( commVal ) := pstVal
    END;
    
    setCommText ( commVal, txtVal ) =
    PRE
        commVal : comments &
        txtVal : STR - {commentText(commVal)}&
        // all comment of user from commVal at post from comVal != txtVal
        ! cc . ( cc : commentUser~[{commentUser(commVal)}] & commentPost(commVal)=commentPost(cc) =>
            commentText(cc) /= txtVal)
    THEN
        commentText ( commVal ) := txtVal
    END;
    
    deleteAllCommentsOfUser(userVal) =
    PRE
        userVal: users
    THEN
        comments := comments - commentUser~[{userVal}] ||
        commentUser := commentUser |>> {userVal} ||
        commentPost := commentUser~[{userVal}] <<| commentPost ||
        commentText := commentUser~[{userVal}] <<| commentText ||
        commentId := commentUser~[{userVal}] <<| commentId
    END;
    
    deleteAllCommentFromPost(pstVal) =
    PRE
        pstVal: posts
    THEN
        comments := comments - commentPost~[{pstVal}] ||
        commentPost := commentPost |>> {pstVal} ||
        commentUser := commentPost~[{pstVal}] <<| commentUser ||
        commentText := commentPost~[{pstVal}] <<| commentText ||
        commentId := commentPost~[{pstVal}] <<| commentId
    END;
    
    deleteAllCommentFromPosts ( postsValue ) =
    PRE
        postsValue : POW(posts)
    THEN
        comments := comments - commentPost~[postsValue] ||
        commentPost := commentPost |>> postsValue ||
        commentUser := commentPost~[postsValue] <<| commentUser ||
        commentText := commentPost~[postsValue] <<| commentText ||
        commentId := commentPost~[postsValue] <<| commentId
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
    END
    
END