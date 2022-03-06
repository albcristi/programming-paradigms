/* Company
 * Author: Cristi
 * Creation date: 12/5/2021
 */
MACHINE
    Company
SEES
    String
SETS
    COMPANY
VARIABLES
    companies,
    companyName,
    companyEmail,
    companyPhone,
    companyWebsite
INVARIANT
    companies <: COMPANY &
    companyName : companies >-> STR &
    companyEmail : companies >-> STR &
    companyPhone : companies --> STR &
    companyWebsite : companies --> STR
INITIALISATION
    companies,
    companyName,
    companyEmail,
    companyPhone,
    companyWebsite := {} , {} , {} , {} , {}
OPERATIONS
    
    newCompany <-- createCompany ( name, email, phone, website) =
    PRE
        name: STR & name /: ran ( companyName ) &
        email : STR & email /: ran ( companyEmail ) &
        phone : STR &
        website : STR
    THEN
        ANY comp
        WHERE
            comp : COMPANY - companies
        THEN
            companies := companies \/ { comp } ||
            companyName ( comp ) := name ||
            companyEmail ( comp ) := email ||
            companyPhone ( comp ) := phone ||
            companyWebsite ( comp ) := website ||
            newCompany := comp
        END
    END;
    
    deleteCompany ( companyValue ) =
    PRE
        companyValue : companies
    THEN
        companies := companies - { companyValue } ||
        companyName := { companyValue } <<| companyName ||
        companyEmail := { companyValue } <<| companyEmail ||
        companyPhone := { companyValue } <<| companyPhone ||
        companyWebsite := { companyValue } <<| companyWebsite
     END;
     
     setCompanyName ( companyValue, nameVal ) =
     PRE
         companyValue : dom (companyName) &
         nameVal : STR &
                   nameVal /: ran ( companyName )
     THEN    
         companyName ( companyValue ) := nameVal
     END;
     
     setCompanyEmail ( companyValue, emailVal ) =
     PRE
         companyValue : dom(companyEmail) &
         emailVal : STR & emailVal /: ran ( companyEmail )
     THEN
         companyEmail ( companyValue ) := emailVal
     END;
     
     setCompanyPhoneNo ( companyValue, phoneNo ) =
     PRE
         companyValue : dom(companyPhone) &
         phoneNo : STR
     THEN
         companyPhone ( companyValue ) := phoneNo
     END;
     
     setCompanyWebsite ( companyValue, websiteVal ) =
     PRE
         companyValue : dom(companyWebsite) &
         websiteVal : STR
     THEN
         companyWebsite ( companyValue ) := websiteVal
     END;
     
     companyNameValue <-- getCompanyName ( companyVal ) =
     PRE
         companyVal : companies
     THEN
         companyNameValue := companyName ( companyVal )
     END;
     
     companyEmailValue <-- getCompanyEmail ( companyVal ) =
     PRE
         companyVal : companies
     THEN
         companyEmailValue := companyEmail ( companyVal )
     END;
     
     companyPhoneValue <-- getCompanyPhone ( companyVal ) =
     PRE
         companyVal : companies
     THEN
         companyPhoneValue := companyPhone ( companyVal )
     END;
     
     companyWebsiteValue <-- getCompanyWebsite ( companyVal ) =
     PRE
         companyVal : companies
     THEN
         companyWebsiteValue := companyWebsite ( companyVal )
     END
END
