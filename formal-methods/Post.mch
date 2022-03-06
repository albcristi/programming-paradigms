/* Post
 * Author: Cristi
 * Creation date: 12/5/2021
 */
MACHINE
    Post
SEES
    String
USES
    User
SETS
    POST
VARIABLES
    posts,
    postId,
    postAuthor,
    postTitle,
    postText,
    postLikes,
    postViews
INVARIANT
    posts <: POST &
    postId : posts >-> NATURAL1 &
    postAuthor : posts --> users &
    postTitle : posts --> STR &
    postText : posts --> STR &
    postLikes : posts --> POW ( users ) &
    postViews : posts --> POW ( users ) &
    /*FOR ANY POST THEN THE AUTHOR IS NOT INCLUDED IN LIKE LIST*/
    ! post . ( post : posts => postAuthor ( post ) /: postLikes ( post ) ) &
    /*FOR ANY POST THEN THE AUTHOR IS NOT INCLUDED IN VIEWS LIST*/
    ! post . ( post :posts => postAuthor ( post ) /: postViews ( post ) ) &
    /*FOR ANY POST THEN ANY OTHER ARTICLE WRITTEN BY THAT AUTHOR CAN NOT HAVE THE SAME TITLE*/
//    ! post . ( post : posts => ! otherPost . ( otherPost : posts - { post } & postAuthor ( post ) = postAuthor ( otherPost ) => postTitle ( post ) /= postTitle ( otherPost ) ) )
      ! post . ( post :posts => ! otherPost . ( otherPost : postAuthor~[{postAuthor(post)}]-{post} => postTitle(post) /= postTitle(otherPost) ) )
INITIALISATION 
    posts,
    postId,
    postAuthor,
    postTitle,
    postLikes,
    postViews,
    postText := {}, {}, {}, {}, {}, {}, {} 
OPERATIONS
    setPostAuthor ( postValue, authorVal ) =
    PRE
        postValue : posts &
        authorVal : users - { postAuthor ( postValue ) }
                    & authorVal /: postLikes ( postValue )
                    & authorVal /: postViews ( postValue )
                    & postTitle ( postValue ) /: postTitle[postAuthor~[{authorVal}]]
    THEN
        postAuthor ( postValue ) := authorVal
    END;
    
    setPostTitle ( postValue, titleValue ) =
    PRE
        postValue : posts &
        titleValue : STR &
            titleValue /: postTitle[postAuthor~[{postAuthor(postValue)}]]
    THEN
        postTitle ( postValue ) := titleValue
    END;
    
    setPostText ( postValue, textValue ) =
    PRE
        postValue :posts &
        textValue : STR
    THEN
        postText ( postValue ):= textValue
    END;
    
    postAuthorVal <-- getPostAuthor ( postValue ) =
    PRE
        postValue : posts
    THEN
         postAuthorVal := postAuthor ( postValue )
    END;
    
    postTitleVal <-- getPostTitle ( postValue ) =
    PRE
        postValue : posts
    THEN
        postTitleVal := postTitle ( postValue )
    END;
    
    postTextVal <-- getPostText ( postValue ) =
    PRE
        postValue : posts
    THEN
        postTextVal := postText ( postValue )
    END;
    
    likeValue <-- getPostLikes ( postValue ) =
    PRE
        postValue : posts
    THEN
        likeValue := postLikes ( postValue )
    END;
    
    viewsValue <-- getPostViews ( postValue ) =
    PRE
        postValue : posts
    THEN
        viewsValue := postViews ( postValue )
    END;
    
    addPostView ( postValue, user ) =
    PRE
        postValue : posts &
        user : users & postAuthor ( postValue ) /= user
    THEN
        postViews ( postValue ) := postViews ( postValue ) \/ { user }
    END;
    
    addPostLike ( postValue, user ) =
    PRE
        postValue : posts &
        user : users & postAuthor ( postValue ) /= user
    THEN
        postLikes ( postValue ) := postLikes ( postValue ) \/ { user }
    END;
    
    newPost <-- createPost ( author, title, text ) =
    PRE
        author : users &
        text : STR &
        title : STR - postTitle[postAuthor~[{author}]]
    THEN
        ANY post 
        WHERE post : POST - posts
        THEN
            posts := posts \/ { post } ||
            ANY idValue 
            WHERE idValue : NATURAL1 & idValue /: ran ( postId )
            THEN
                postId ( post ) := idValue
            END ||
            postTitle ( post ) :=  title ||
            postAuthor ( post ) := author ||
            postText ( post ) := text ||
            postViews ( post ) := {} ||
            postLikes ( post ) := {} ||
            newPost := post
        END
    END;
    
    removePost ( postValue ) =
    PRE
        postValue : posts
    THEN
        posts := posts - { postValue } ||
        postId := { postValue } <<| postId ||
        postTitle := { postValue } <<| postTitle ||
        postText := { postValue } <<| postText ||
        postAuthor := { postValue } <<| postAuthor ||
        postLikes := { postValue } <<| postLikes ||
        postViews := { postValue } <<| postViews
    END;
    
    
    removeAllUserPosts(usrVal) =
    PRE
        usrVal : users
    THEN
        posts := posts - postAuthor~[{usrVal}] ||
        postAuthor :=  postAuthor |>> {usrVal} ||
        postId := postAuthor~[{usrVal}] <<| postId ||
        postTitle := postAuthor~[{usrVal}] <<| postTitle ||
        postText := postAuthor~[{usrVal}] <<| postText ||
        postLikes := postAuthor~[{usrVal}] <<| postLikes ||
        postViews := postAuthor~[{usrVal}] <<| postViews
    END
        
END
