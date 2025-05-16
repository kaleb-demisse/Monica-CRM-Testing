*** Settings ***
Library    SeleniumLibrary
Variables    ../variables.py

*** Variables ***
${BROWSER}                   chrome
${URL}                       http://localhost:8080/login
${DASHBOARD_URL}            http://localhost:8080/dashboard
${CONTACTS_LIST_PAGE_URL}    http://localhost:8080/people
${ADD_CONTACT_FORM_URL}      http://localhost:8080/people/add

${VALID_EMAIL}               ${EMAIL}
${VALID_PASSWORD}            ${PASSWORD}
${INVALID_PASSWORD}          thisiswrongpassword123
${SAMPLE_FIRST_NAME}         Abebe
${SAMPLE_MIDDLE_NAME}        Kebede
${SAMPLE_LAST_NAME}          Bekele
${SAMPLE_GENDER}             1

${LOGIN_EMAIL_FIELD}         id=email
${LOGIN_PASSWORD_FIELD}      id=password
${FIRST_NAME_FIELD}          id=first_name6
${MIDDLE_NAME_FIELD}         id=middle_name7
${LAST_NAME_FIELD}           id=last_name8
${NICKNAME_FIELD}            name:nickname
${GENDER_SELECT}             id=gender10
${LOGIN_BUTTON}              xpath=//button[text()='Login']
${LOGIN_ERROR_MESSAGE}       xpath=//*[contains(text(),'These credentials do not match our records.')]
${EXPECTED_ERROR_TEXT}       These credentials do not match our records.

${LOGOUT_LINK_OR_BUTTON}     link=Logout
${SUBMIT_ADD_CONTACT_BUTTON}   xpath=//button[@name='save' and @value='true' and normalize-space()='Add']


*** Test Cases ***


*** Test Cases ***
TC_RT_002 - Verify viewing an existing relationship for a contact
    [Documentation]  FR3.2, NFR2.2 Verify that a user can view existing relationships of a contact
    [Tags]  RelationshipManagement
    [Setup]  Open Browser  ${URL}  ${BROWSER}
    [Teardown]  Close Browser
    Wait Until Element Is Visible   ${LOGIN_EMAIL_FIELD}  15s
    Enter Login Credentials  ${VALID_EMAIL}  ${VALID_PASSWORD}
    Wait Until Element Is Visible  ${LOGIN_BUTTON}  15s
    Click Element  ${LOGIN_BUTTON}
    Wait Until Location Is  ${DASHBOARD_URL}  15s
    Go To     ${CONTACTS_LIST_PAGE_URL}
    Wait Until Page Contains Element  xpath=//table  20s
    Sleep  2s
    Click Element  xpath=//*[contains(text(), '${SAMPLE_FIRST_NAME}')]
    Wait Until Page Contains  ${SAMPLE_FIRST_NAME}  15s

    Wait Until Page Contains Element  xpath=//h3[contains(., 'Family')]/following::a[contains(., 'Amanuel')][1]  15s
    Click Element  xpath=//h3[contains(., 'Family')]/following::a[contains(., 'Amanuel')][1]

    

*** Keywords ***
Enter Login Credentials
    [Arguments]  ${email}  ${password}
    Input Text  ${LOGIN_EMAIL_FIELD}  ${email}
    Input Text  ${LOGIN_PASSWORD_FIELD}  ${password}
