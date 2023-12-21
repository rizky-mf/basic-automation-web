*** Settings ***
Library           SeleniumLibrary

*** variables ***
${BROWSER}     chrome
${HOST}    http://localhost/DataKaryawan/

${EMAIL}    admin
${PASS-1}    admin    # correct password
${PASS-2}    zzzzzz    # wrong password
${PASS-3}   rizky      # add password

${KARYAWAN}    Rizky Maolana Firdaus
${TITLE}    [TEST] Senior Engineering manager
${LOCATION}     Singapore
${TAGS}    engineering manager software
${JOBEMAIL}    jobs@global.co
${WEBSITE}    https://global.co
${DESCRIPTION}     Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 

*** Test Cases ***

# login
# positive test
testcase-1
    Login Success
    Close Browser 

# negative test
testcase-2
    Open Browser    ${HOST}    ${BROWSER}
    Page Should Contain Element   xpath://input[@name='username']
    input text        name:username       ${EMAIL}
    input text        name:password    ${PASS-2}
    input text        name:nama       ${EMAIL}
    Click Element    xpath://option[@value='1']
    Click Element   xpath://select[@name='level']
    Click Element     xpath://input[@type='submit']
    Page Should Contain Element    xpath://h1[contains(text(), 'Silahkan Login Terlebih Dahulu')]
    Close Browser 

# logout
testcase-3
    Login Success
    Click Element    xpath://div[@class='menu']//a[@class='menuNavbar' and @href='logout.php']
    Page Should Contain Element    xpath://h1[contains(text(), 'Silahkan Login Terlebih Dahulu')]
    Close Browser

#post job
testcase-4
    Login Success
    Click Element    xpath://a[@id='inputUser' and contains(@class, 'menuNavbar') and @href='inputuser.php']
    Page Should Contain Element    xpath://h1[contains(text(), 'Input Data User')]
    input text        name:username       ${KARYAWAN}
    input text        name:password    ${PASS-3}
    input text        name:nama       ${KARYAWAN}
    Click Element   xpath://select[@name='level']
    Click Element    xpath://option[@value='user']
    Click Element     xpath://input[@type='submit']
    Close Browser 

# delete post
testcase-5
    Login Success
    Click Element    xpath://a[contains(@class, 'menuNavbar') and @href='viewAllUser.php']
    Click Element    xpath://a[@href='deleteuser.php?id=4']
    Close Browser
    
testcase-6
    Login Success
    Click Element    xpath://a[contains(@class, 'menuNavbar') and @href='viewAllPegawai.php']
    Scroll Down Until End
    Close Browser

*** Keywords ***

Scroll Down Until End
    ${previous_height}=    Execute Javascript    return document.body.scrollHeight;
    FOR  ${i}    IN RANGE    10
        Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
        Sleep    1s
        ${current_height}=    Execute Javascript    return document.body.scrollHeight;
        Exit For Loop If    '${current_height}' == '${previous_height}'
        ${previous_height}=    Set Variable    ${current_height}
        Sleep    2s
    END

Login Success
    Open Browser    ${HOST}    ${BROWSER}
    Page Should Contain Element   xpath://input[@name='username']
    input text        name:username       ${EMAIL}
    input text        name:password    ${PASS-1}
    input text        name:nama       ${EMAIL}
    Click Element   xpath://select[@name='level']
    Click Element    xpath://option[@value='1']
    Click Element     xpath://input[@type='submit']
    Page Should Contain Element    xpath://body//h1[contains(@class, 'tulisan_admin')]