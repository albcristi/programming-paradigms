/* Sponsorship
 * Author: Cristi
 * Creation date: 12/11/2021
 */
MACHINE
    Sponsorship
SETS
    SPONSORSHIP
SEES
    String
USES
    SimplePostingSystem,
    Company
VARIABLES
    sponsorships,
    sponsorshipId,
    post,
    company,
    like,
    view,
    comment
INVARIANT
    sponsorships <: SPONSORSHIP &
    sponsorshipId : sponsorships >-> NATURAL1 &
    post : sponsorships --> posts &
    company : sponsorships --> companies &
    like : sponsorships --> REAL & 
    view : sponsorships --> REAL & 
    comment : sponsorships --> REAL &
    ! sp . ( sp : sponsorships => like ( sp ) + view ( sp ) + comment ( sp ) > 0.0 & like ( sp ) >= 0.0 & view ( sp ) >= 0.0 & comment ( sp ) >= 0.0 ) &
    //A company can sponsorship a post only once 
    ! sp . ( sp: sponsorships => ! sps . ( sps : company~[{company(sp)}]-{sp} => postId (post(sp)) /= postId  (post(sps))))
INITIALISATION
    sponsorships,
    sponsorshipId,
    post,
    company,
    like,
    view,
    comment := {}, {}, {}, {}, {}, {}, {}
OPERATIONS
    
    newSp <-- newSponsorship ( pst, comp, likes, comms, views ) =
    PRE
        comp : companies &
        pst : posts - post[company~[{comp}]]&
        likes : REAL & likes >= 0.0 &
        comms : REAL & comms >= 0.0 &
        views : REAL & views >= 0.0 &
            likes + comms + views > 0.0
    THEN
        ANY sp
        WHERE
            sp : SPONSORSHIP - sponsorships
        THEN
            sponsorships := sponsorships \/ { sp } ||
            ANY idValue 
            WHERE idValue : NATURAL1 & idValue /: ran ( sponsorshipId )
            THEN
                sponsorshipId ( sp ) := idValue
            END ||
            company ( sp ) := comp ||
            post ( sp ) := pst ||
            like ( sp ) := likes ||
            view ( sp ) := views ||
            comment ( sp ) := comms ||
            newSp := sp
        END
    END;
        
    removeSponsorship ( spVal ) =
    PRE
        spVal : sponsorships
    THEN
        sponsorships := sponsorships - { spVal } ||
        post := { spVal } <<| post ||
        sponsorshipId := { spVal } <<| sponsorshipId ||
        company := { spVal } <<| company ||
        like := { spVal } <<| like ||
        view := { spVal } <<| view ||
        comment := { spVal } <<| comment
    END;
    
    idVal <-- getSponsorshipId ( sponsorshipVal ) =
    PRE
        sponsorshipVal : sponsorships
    THEN
        idVal := sponsorshipId ( sponsorshipVal )
    END;
    
    postVal <-- getSponsoredPost ( spVal ) =
    PRE
        spVal : sponsorships
    THEN
        postVal := post ( spVal )
    END;
    
    compVal <-- getSponsor ( spVal ) =
    PRE
        spVal : sponsorships
    THEN
        compVal := company ( spVal )
    END;
    
    likeVal <-- getLikeVal ( spVal ) =
    PRE
        spVal : sponsorships
    THEN
        likeVal := like ( spVal )
    END;
    
    viewVal <-- getViewVal ( spVal ) =
    PRE
        spVal : sponsorships
    THEN
        viewVal := view ( spVal )
    END;
    
    commentVal <-- getComentVal ( spVal ) =
    PRE
        spVal : sponsorships
    THEN
        commentVal := comment ( spVal )
    END;
    
    setPost ( spVal, pst ) =
    PRE
        spVal : dom(post) &
        /* make sure the new post is not having a sponsorship from the current sponsorship (spVal) comp  */
        pst : posts - post[company~[{company(spVal)}]]
    THEN
        post ( spVal ) := pst
    END;
    
    setCompany ( spVal, comp ) =
    PRE
        spVal : dom(company) &
        comp : companies - company[post~[{post(spVal)}]]
    THEN
        company ( spVal ) := comp
    END;
    
    setLikes ( spVal, likes ) =
    PRE
        spVal : dom(like) &
        likes : REAL &
            likes >= 0.0 &  likes + comment ( spVal ) + view ( spVal ) > 0.0
    THEN
        like ( spVal ) := likes
    END;
    
    setComment ( spVal, comms ) =
    PRE
        spVal : dom(comment) &
        comms : REAL &
            comms >= 0.0 & like ( spVal ) + comms + view ( spVal ) > 0.0
    THEN
        comment ( spVal ) := comms
    END;
    
    setView ( spVal, views ) =
    PRE
        spVal : dom(view) &
        views : REAL &
            views >= 0.0 & like ( spVal ) + comment ( spVal ) + views > 0.0
    THEN
        view ( spVal ) := views
    END;
    
    removeAllSponsorshipsOfACompany(compValue) =
    PRE
        compValue: companies
    THEN
        sponsorships := sponsorships - company~[{compValue}] ||
        company := company |>> {compValue} ||
        sponsorshipId := company~[{compValue}] <<| sponsorshipId ||
        post := company~[{compValue}] <<| post ||
        like := company~[{compValue}] <<| like ||
        view := company~[{compValue}] <<| view ||
        comment := company~[{compValue}] <<| comment
    END;
    
    
    removePostSponsorships(postValue) =
    PRE
        postValue : posts
    THEN
        sponsorships := sponsorships - post~[{postValue}] ||
        post := post |>> {postValue} ||
        company := post~[{postValue}] <<| company ||
        sponsorshipId := post~[{postValue}] <<| sponsorshipId ||
        like := post~[{postValue}] <<| like ||
        view := post~[{postValue}] <<| view ||
        comment := post~[{postValue}] <<| comment
    END;
    
    removeAllSponsosrshipsFromPosts (postsVal) =
    PRE
        postsVal : POW(posts) 
    THEN
        sponsorships := sponsorships - post~[postsVal] ||
        post := post |>> postsVal ||
        company := post~[postsVal] <<| company ||
        sponsorshipId := post~[postsVal] <<| sponsorshipId ||
        like := post~[postsVal] <<| like ||
        view := post~[postsVal] <<| view ||
        comment := post~[postsVal] <<| comment
    END
END

