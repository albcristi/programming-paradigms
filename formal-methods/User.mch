/* User
 * Author: Cristi
 * Creation date: 12/5/2021
 */
MACHINE
    User
SEES
    String
SETS
    USER
VARIABLES
    users,
    userId,
    userFName,
    userLName,
    userEmail,
    userMoney,
    userPassword
INVARIANT
    users <: USER &
    userId : users >-> NATURAL1 &
    userFName : users --> STR &
    userLName : users --> STR &
    userEmail : users >-> STR &
    userMoney : users --> REAL &
    userPassword : users --> STR - {}
INITIALISATION
    users,
    userId,
    userFName,
    userLName,
    userMoney,
    userPassword,
    userEmail := {} , {} , {} , {} , {}, {}, {}
OPERATIONS
    newUser <-- createUser ( fName, lName, email, money, passw ) =
    PRE
        fName : STR &
        lName : STR &
        money: REAL & money >= 0.0 &
        passw: STR - {} &
        email : STR - {} &
                email /: ran ( userEmail )
    THEN
        ANY usr 
        WHERE usr : USER - users
        THEN
            users := users \/ { usr } ||
            ANY idValue 
            WHERE idValue : NATURAL1 & idValue /: ran ( userId )
            THEN
                userId ( usr ) := idValue
            END ||
            userFName ( usr ) :=  fName ||
            userLName ( usr ) := lName ||
            userEmail ( usr ) := email ||
            userMoney ( usr ) := money ||
            userPassword ( usr ) := passw ||
            newUser := usr
        END
    END;
    
    setUserFName ( userValue, fNameValue ) =
    PRE
        userValue : users &
        fNameValue : STR
    THEN
        userFName ( userValue ) := fNameValue
    END;
    
    setUserLName ( userValue, lNameValue ) =
    PRE
        userValue : users &
        lNameValue : STR
    THEN
        userLName ( userValue ) := lNameValue
    END;
    
    setUserEmail ( userValue, emailValue ) =
    PRE
        userValue : users &
        emailValue : STR &
        emailValue /: ran ( userEmail )
    THEN
       userEmail ( userValue ) := emailValue
    END;
    
    setUserMoney ( userValue, money ) =
    PRE
        userValue : users &
        money : REAL & money >= 0.0
    THEN
        userMoney ( userValue ) := money
    END;
    
    setUserPassword ( userValue, passVal ) =
    PRE
        userValue : users &
        passVal : STR - {}
    THEN
        userPassword ( userValue ) := passVal
    END;
    
    idValue <-- getUserId ( userValue ) =
    PRE
        userValue : users
    THEN
        idValue := userId ( userValue )
    END;
    
    fNameValue <-- getUserFName ( userValue ) =
    PRE
        userValue : users
    THEN
        fNameValue := userFName ( userValue )
    END;
    
    lNameValue <-- getUserLName ( userValue ) =
    PRE
        userValue : users
    THEN
        lNameValue := userLName ( userValue )
    END;
    
    emailValue <-- getUserEmail ( userValue) =
    PRE
        userValue : users
    THEN
        emailValue := userEmail ( userValue)
    END;
    
    moneyValue <-- getUserMoney ( userValue ) =
    PRE
        userValue : users
    THEN
        moneyValue := userMoney ( userValue )
    END;
    
    passwordVal <-- getUserPassword ( userValue ) =
    PRE
        userValue : users
    THEN
        passwordVal := userPassword ( userValue )
    END;
    
    disableUser ( userValue ) =
    PRE
        userValue : users
    THEN
        users := users - { userValue } ||
        userId := { userValue } <<| userId ||
        userFName := { userValue } <<| userFName ||
        userLName := { userValue } <<| userLName ||
        userEmail := { userValue } <<| userEmail ||
        userPassword := { userValue } <<| userPassword ||
        userMoney := { userValue } <<| userMoney
    END 
END
