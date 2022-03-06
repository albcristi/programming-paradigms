
MACHINE
    Comment
SEES
    String
USES
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
INITIALISATION
    comments,
    commentId,
    commentUser,
    commentPost,
    commentText := {}, {}, {}, {}, {}
OPERATIONS    
    addNewComment ( usr, pst, txt ) =
    PRE
        usr : users & 
        pst : posts - postAuthor~[{usr}] &
        txt : STR
    THEN
        ANY comm 
        WHERE comm : COMMENT - comments
        THEN
            comments := comments \/ { comm } ||
            ANY idValue 
            WHERE idValue : NATURAL1 & idValue /: ran ( commentId )
            THEN
                commentId ( comm ) := idValue
            END ||
            commentUser ( comm ) := usr ||
            commentPost ( comm ) := pst ||
            commentText ( comm ) := txt 
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
       usrVal: users &
       commVal: comments - commentPost~[postAuthor~[{usrVal}]]
    THEN
        commentUser ( commVal ) := usrVal
    END;
    
    setCommPost ( commVal , pstVal ) =
    PRE
       commVal: comments &
       pstVal: posts - postAuthor~[{commentUser(commVal)}]
    THEN
        commentPost ( commVal ) := pstVal
    END;
    
    setCommText ( commVal, txtVal ) =
    PRE
        commVal : comments &
        txtVal : STR - {commentText(commVal)}
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
    END
END