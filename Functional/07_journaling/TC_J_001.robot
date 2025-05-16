*** Settings ***
Library    SeleniumLibrary
Variables    ../variables.py

*** Variables ***
${BROWSER}                   chrome
${URL}                       http://localhost:8080/login
${DASHBOARD_URL}             http://localhost:8080/dashboard
${JOURNAL_PAGE_URL}          http://localhost:8080/journal
${JOURNAL_CREATE_URL}        http://localhost:8080/journal/add

${VALID_EMAIL}               ${EMAIL}
${VALID_PASSWORD}            ${PASSWORD}

${LOGIN_EMAIL_FIELD}         id=email
${LOGIN_PASSWORD_FIELD}      id=password
${LOGIN_BUTTON}              xpath=//button[text()='Login']

${JOURNAL_TITLE_FIELD}       id=field-title
${JOURNAL_DATE_FIELD}        id=field-date
${JOURNAL_ENTRY_FIELD}       id=field-entry
${JOURNAL_SAVE_BUTTON}       css=button[cy-name="save-entry-button"]

*** Test Cases ***
TC_J_001 - Verify successful creation of a new journal entry
    [Documentation]    FR7.1 Verify successful creation of a new journal entry in Monica CRM
    [Tags]    Journaling
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${LOGIN_EMAIL_FIELD}    15s
    Enter Login Credentials    ${VALID_EMAIL}    ${VALID_PASSWORD}
    Click Element    ${LOGIN_BUTTON}
    Wait Until Location Is    ${DASHBOARD_URL}    15s
    Go To    ${JOURNAL_CREATE_URL}
    Wait Until Element Is Visible    ${JOURNAL_ENTRY_FIELD}    15s
    Input Text    ${JOURNAL_TITLE_FIELD}    Productive day
    Input Text    ${JOURNAL_DATE_FIELD}     05-14-2025
    Input Text    ${JOURNAL_ENTRY_FIELD}    Today was a productive day. Completed all tasks on time!
    Click Button    ${JOURNAL_SAVE_BUTTON}
    Wait Until Location Contains    /journal    15s
    Page Should Contain    Productive day
    Close Browser

*** Keywords ***
Enter Login Credentials
    [Arguments]    ${email}    ${password}
    Input Text    ${LOGIN_EMAIL_FIELD}    ${email}
    Input Text    ${LOGIN_PASSWORD_FIELD}    ${password}
