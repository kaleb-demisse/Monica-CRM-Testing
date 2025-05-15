*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}                   chrome
${URL}                       http://localhost:8080/login
${DASHBOARD_URL}            http://localhost:8080/dashboard
${CONTACTS_LIST_PAGE_URL}    http://localhost:8080/people
${ADD_CONTACT_FORM_URL}      http://localhost:8080/people/add

${VALID_EMAIL}               kalebdemisse4@gmail.com
${VALID_PASSWORD}            Kk@45482452
${FIRST_NAME_FIELD}          id=first_name6
${MIDDLE_NAME_FIELD}         id=middle_name7
${LAST_NAME_FIELD}           id=last_name8
${NICKNAME_FIELD}            name:nickname
${GENDER_SELECT}             id=gender10

${SAMPLE_FIRST_NAME}         Abebe
${SAMPLE_MIDDLE_NAME}        Kebede
${SAMPLE_LAST_NAME}          Bekele
${SAMPLE_GENDER}             1
${RELATED_CONTACT_NAME}      Amanuel Tesfaye
${RELATION_TYPE}             Brother  # Choose exactly as shown in dropdown

${LOGIN_EMAIL_FIELD}         id=email
${LOGIN_PASSWORD_FIELD}      id=password
${LOGIN_BUTTON}              xpath=//button[text()='Login']
${LOGOUT_LINK_OR_BUTTON}     link=Logout
${SUBMIT_ADD_CONTACT_BUTTON}   xpath=//button[@name='save' and @value='true' and normalize-space()='Add']


*** Test Cases ***
TC_RT_001 - Verify adding a new relationship for a contact
    [Documentation]  FR3.1, NFR2.2 - Verify that a user can add a new relationship to an existing contact
    [Tags]  RelationshipManagement
    [Setup]  Open Browser  ${URL}  ${BROWSER}
    [Teardown]  Close Browser

    Wait Until Element Is Visible   ${LOGIN_EMAIL_FIELD}  15s
    Enter Login Credentials  ${VALID_EMAIL}  ${VALID_PASSWORD}
    Wait Until Element Is Visible  ${LOGIN_BUTTON}  15s
    Click Element  ${LOGIN_BUTTON}
    Wait Until Location Is  ${DASHBOARD_URL}  15s

    Go To     ${ADD_CONTACT_FORM_URL}
    Input Text    ${FIRST_NAME_FIELD}    ${SAMPLE_FIRST_NAME}
    Input Text    ${MIDDLE_NAME_FIELD}    ${SAMPLE_MIDDLE_NAME}
    Input Text    ${LAST_NAME_FIELD}    ${SAMPLE_LAST_NAME}
    Select From List By Value    ${GENDER_SELECT}    ${SAMPLE_GENDER}
    Click Button    ${SUBMIT_ADD_CONTACT_BUTTON}
    Wait Until Element Is Visible   class=mr1     15s

    Go To     ${CONTACTS_LIST_PAGE_URL}
    Wait Until Page Contains Element  xpath=//table  15s
    Click Element  xpath=//*[contains(text(), '${SAMPLE_FIRST_NAME}')]
    Wait Until Page Contains  ${SAMPLE_FIRST_NAME}  10s

    # Click "Add" under the "Family relationships" section
    Wait Until Page Contains Element  xpath=//h3[contains(., 'Family')]/following::a[contains(., 'Add')][1]  15s
    Click Element  xpath=//h3[contains(., 'Family')]/following::a[contains(., 'Add')][1]


    # Fill the form
    Wait Until Page Contains Element    id=first_name6    timeout=10s
    Input Text    id=first_name6    Amanuel
    Input Text    id=last_name7     Tesfaye
    Select From List By Value    id=gender_id8    1
    Click Element    xpath=//input[@name="birthdate" and @value="unknown"]
    Click Button    xpath=//button[@type="submit"]
    Sleep  3s

*** Keywords ***
Enter Login Credentials
    [Arguments]  ${email}  ${password}
    Input Text  ${LOGIN_EMAIL_FIELD}  ${email}
    Input Text  ${LOGIN_PASSWORD_FIELD}  ${password}
