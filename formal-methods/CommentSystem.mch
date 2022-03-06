/* CommentSystem
 * Author: Cristi
 * Creation date: 12/12/2021
 */
/* Comment
 * Author: Cristi
 * Creation date: 12/11/2021
 */
MACHINE
    CommentSystem
SEES
    String
INCLUDES
    User ,
    Post
SETS
    COMMENTSYSTEMS
VARIABLES
    comments,
    commentId,
    commentUser,
    commentPost,
    commentText
INVARIANT
    comments <: COMMENTSYSTEMS &
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
    newComment <-- createComment ( usr, pst, txt ) =
    PRE
        usr : users &
        pst : posts - postAuthor~[{usr}] &
        txt : STR &
             userId ( usr ) /= userId ( postAuthor ( pst ) )
    THEN
        ANY comm 
        WHERE comm : COMMENTSYSTEMS - comments
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
    THEN
        commentUser ( commVal ) := usrVal
    END
END
