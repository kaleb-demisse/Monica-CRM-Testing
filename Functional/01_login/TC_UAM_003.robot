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

${LOGIN_EMAIL_FIELD}         id=email
${LOGIN_PASSWORD_FIELD}      id=password
${LOGIN_BUTTON}              xpath=//button[text()='Login']
${LOGIN_ERROR_MESSAGE}       xpath=//*[contains(text(),'These credentials do not match our records.')]
${EXPECTED_ERROR_TEXT}       These credentials do not match our records.

${LOGOUT_LINK_OR_BUTTON}     link=Logout
${SUBMIT_ADD_CONTACT_BUTTON}   xpath=//button[@name='save' and @value='true' and normalize-space()='Add']


*** Test Cases ***
TC_UAM_003 - Verify successful user logout
    [Setup]     Open Browser  ${URL}  ${BROWSER}
    [Teardown]  Close Browser
    Wait Until Element Is Visible  ${LOGIN_EMAIL_FIELD}  15s
    Enter Login Credentials  ${VALID_EMAIL}  ${VALID_PASSWORD}
    Wait Until Element Is Visible  ${LOGIN_BUTTON}  15s
    Click Element  ${LOGIN_BUTTON}
    Wait Until Location Is  ${DASHBOARD_URL}  15s
    Click Element  ${LOGOUT_LINK_OR_BUTTON}
    Go To  ${URL}
    Sleep  3s
    Location Should Be  ${URL}

*** Keywords ***
Enter Login Credentials
    [Arguments]  ${email}  ${password}
    Input Text  ${LOGIN_EMAIL_FIELD}  ${email}
    Input Text  ${LOGIN_PASSWORD_FIELD}  ${password}
