*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}                   chrome
${URL}                       http://localhost:8080/login
${DASHBOARD_URL}             http://localhost:8080/dashboard
${JOURNAL_PAGE_URL}          http://localhost:8080/journal
${JOURNAL_CREATE_URL}        http://localhost:8080/journal/add

${VALID_EMAIL}               kalebdemisse4@gmail.com
${VALID_PASSWORD}            Kk@45482452

${LOGIN_EMAIL_FIELD}         id=email
${LOGIN_PASSWORD_FIELD}      id=password
${LOGIN_BUTTON}              xpath=//button[text()='Login']

${JOURNAL_TITLE_FIELD}       id=field-title
${JOURNAL_DATE_FIELD}        id=field-date
${JOURNAL_ENTRY_FIELD}       id=field-entry
${JOURNAL_SAVE_BUTTON}       css=button[cy-name="save-entry-button"]

*** Test Cases ***

TC_J_003 - Verify successful editing of a journal entry
    [Documentation]  FR7.1 Verify successful editing of a journal entry
    [Tags]  Journaling
    [Setup]     Open Browser  ${URL}  ${BROWSER}
    [Teardown]  Close Browser
    Maximize Browser Window
    Wait Until Element Is Visible    ${LOGIN_EMAIL_FIELD}    15s
    Enter Login Credentials    ${VALID_EMAIL}    ${VALID_PASSWORD}
    Click Element    ${LOGIN_BUTTON}
    Wait Until Location Is    ${DASHBOARD_URL}    15s
    Go To    ${JOURNAL_PAGE_URL}
     Wait Until Element Is Visible    xpath=//a[contains(@cy-name,'entry-edit-button')]    15s

    Click Element    xpath=(//a[contains(@cy-name,'entry-edit-button')])[1]

    Wait Until Element Is Visible    id=field-title    10s

    Clear Element Text    id=field-title
    Input Text    id=field-title    Updated productive day

    Click Button    xpath=//button[contains(text(),'Save') or contains(text(),'Update')]

    Wait Until Location Contains    ${JOURNAL_PAGE_URL}    15s

    Wait Until Page Contains Element    xpath=//h3[contains(text(),'Updated productive day')]



*** Keywords ***
Enter Login Credentials
    [Arguments]    ${email}    ${password}
    Input Text    ${LOGIN_EMAIL_FIELD}    ${email}
    Input Text    ${LOGIN_PASSWORD_FIELD}    ${password}
