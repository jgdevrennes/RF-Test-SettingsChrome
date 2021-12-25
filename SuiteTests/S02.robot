*** Settings ***
Documentation       Set download directory on Google Chrome/Chromium.

Resource            ..//Resources//Base.resource

Suite Setup         Suite Setup Base

*** Variables ***
${DOWNLOAD_DIR}         ${CURDIR}//Download    # Put Your Path Here
${URL}                  http://only-testing-blog.blogspot.com/2014/05/login.html 
${CHOICE}               OpenBrowser
${HEADLESS_CHROME}      False  # True
${CHROME_PRIVATE}       False  # True
${DEVTOOLS_CHROME}      False  # True

*** Test Cases ***
Download Files txt/csv/pdf/xlsx/docx With Chrome
    [Setup]  Path Normalizer  ${DOWNLOAD_DIR}

    Launch Chrome Browser  ${URL}    ${DOWNLOAD_DIR}    ${CHOICE}
    Download Files  //a[contains(.,'Download Text File')]
    Download Files  //a[contains(.,'Download CSV File')]
    Download Files  //a[contains(.,'Download Excel File')]
    Download Files  //a[contains(.,'Download Doc File')]
    Download Files  //a[contains(.,'Download PDF File')]
    Verify File Should Exist In Downloading Folder    ${DOWNLOAD_DIR}    *.txt
    Verify File Should Exist In Downloading Folder    ${DOWNLOAD_DIR}    *.csv
    Verify File Should Exist In Downloading Folder    ${DOWNLOAD_DIR}    *.pdf
    Verify File Should Exist In Downloading Folder    ${DOWNLOAD_DIR}    *.xlsx
    Verify File Should Exist In Downloading Folder    ${DOWNLOAD_DIR}    *.docx

    [Teardown]    Close All Browsers