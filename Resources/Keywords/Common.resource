*** Settings ***
Documentation  Keywords Common

*** Keywords ***
Launch Chrome Browser With Download Settings
  [Arguments]    ${URL}  ${DOWNLOAD_DIR}  ${CHOICE}=Option1
  [Documentation]  Settings to download PDF with Chrome on mode view (ko on mode headless)
  ${dict_profile}  Create dictionary  enabled=False  name=Chrome PDF Viewer
  ${list_profile}  Create list  ${dict_profile}
  ${prefs}  Create Dictionary  plugins.plugins_list=${list_profile}
  ...                          plugins.always_open_pdf_externally=True
  ...                          plugins.plugins_disabled=Chrome PDF Viewer
  ...                          download.prompt_for_download=${False}
  ...                          download.default_directory=${DOWNLOAD_DIR}
  ...                          safebrowsing.disable_download_protection=True
  ...                          download.extensions_to_open=xml
  ${chrome_options}  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
  Call Method  ${chrome_options}  add_experimental_option  prefs  ${prefs}

  IF  "${CHOICE}"=="Option1"  # Open Browser
    Open Browser  ${URL}  Chrome  options=${chrome_options}
    Maximize Browser Window
  END

  IF  "${CHOICE}"=="Option2"  # Create Webdriver
    Create Webdriver  Chrome  options=${chrome_options}
    Go to  ${URL}
    Maximize Browser Window
  END 

Download scrumguides English
  ${Source}  Log Source    loglevel=INFO
  SeleniumLibrary.Click Element   ​//a[contains(., 'Download (English)')]

Verify Page ${TEXTE}
  [Documentation]  Verify h1 page
  SeleniumLibrary.Wait Until Page Contains Element  //p[contains(., "${TEXTE}")]  timeout=${IMPLICIT_WAIT_SELENIUM}  error=Page Doesn't Contains //p[contains(., "${TEXTE}")]

Verify File Should Exist In Downloading Folder
  [Arguments]  ${DOWNLOAD_DIR}  ${NAME_FILE}
  Sleep    2 seconds
  OperatingSystem.File Should Exist    ${DOWNLOAD_DIR}\\${NAME_FILE}
