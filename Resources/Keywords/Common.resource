*** Settings ***
Documentation       Keywords Common

*** Keywords ***
Path Normalizer
    [Documentation]  Normalize Path
    [Arguments]    ${PATH}
    ${DOWNLOAD_DIR}  OperatingSystem.Normalize Path  ${PATH}
    Set Test Variable  ${DOWNLOAD_DIR}

Launch Chrome Browser
    [Documentation]    Settings to download PDF with Chrome on mode view
    [Arguments]    ${URL}    ${DOWNLOAD_DIR}    ${CHOICE}=OpenBrowser
    ${profile}  Create dictionary    enabled=${False}  name=chrome PDF Viewer
    ${list profile}  Create list  ${profile}
    ${prefs}  Create Dictionary
    ...    plugins.plugins_list=${list profile}
    ...    plugins.always_open_pdf_externally=${True}
    ...    plugins.plugins_disabled=chrome PDF Viewer
    ...    download.default_directory=${DOWNLOAD_DIR}
    ...    download.prompt_for_download=${False}
    Log  ${prefs}
    ${chrome_options}  Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method  ${chrome_options}  add_experimental_option    prefs  ${prefs}
    IF  '${HEADLESS_CHROME}'=='True'
        Call Method  ${chrome_options}  add_argument    --no-sandbox
        Call Method  ${chrome_options}  add_argument    --disable-gpu
        Call Method  ${chrome_options}  add_argument    --headless
        Call Method  ${chrome_options}  add_argument    --start--maximized
        Call Method  ${chrome_options}  add_argument    --window-size\=1800,1400
        Call Method  ${chrome_options}  add_argument    --disable-dev-shm-usage
        Call Method  ${chrome_options}  add_argument    --disable-software-rasterizer
        Call Method  ${chrome_options}  add_argument    --ignore-certificate-errors
        Call Method  ${chrome_options}  add_argument    --disable-extensions
    END
    IF    "${HEADLESS_CHROME}"=="False"
        IF    "${DEVTOOLS_CHROME}"=="True"
            Call Method    ${chrome_options}    add_argument    --auto-open-devtools-for-tabs
        END
    END
    IF    "${CHROME_PRIVATE}"=="True"
        Call Method    ${chrome_options}    add_argument    --incognito
    END

    IF    "${CHOICE}"=="OpenBrowser"
        Open Browser    ${URL}    Chrome    options=${chrome_options}
        Maximize Browser Window
    END

    IF    "${CHOICE}"=="CreateWebdriver"
        Create Webdriver    Chrome    options=${chrome_options}
        Go to    ${URL}
        Maximize Browser Window
    END

Download scrumguides English
    ${Source}    Log Source    loglevel=INFO
    SeleniumLibrary.Click link    //a[contains(.,"Download (English)")]

Verify Page ${TEXTE}
    [Documentation]    Verify h1 page
    SeleniumLibrary.Wait Until Page Contains Element    //p[contains(., "${TEXTE}")]
    ...    timeout=${IMPLICIT_WAIT_SELENIUM}    error=Page Doesn't Contains //p[contains(., "${TEXTE}")]

Verify File Should Exist In Downloading Folder
    [Arguments]    ${DOWNLOAD_DIR}    ${NAME_FILE}
    Sleep    2 seconds
    OperatingSystem.File Should Exist    ${DOWNLOAD_DIR}\\${NAME_FILE}

Download Files
    [Arguments]    ${locator}
    Sleep  1
    SeleniumLibrary.Click Element  ${locator}
    Sleep  1