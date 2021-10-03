*** Settings ***
Documentation     Set download directory on Google Chrome/Chromium.
Resource  ..//Resources//Base.resource
Suite Setup   Suite Setup Base


*** Variables ***
${DOWNLOAD_DIR}   # Put Your Path Here
${URL}            https://scrumguides.org/
${CHOICE}         Option1
${NAME_FILE}      2020-Scrum-Guide-US.pdf


*** Test Cases ***
Download Pdf With Chrome
  Launch Chrome Browser with Download Settings    ${URL}  ${DOWNLOAD_DIR}  ${CHOICE}
  Verify Page Download the official Scrum Guide PDF in English
  Download scrumguides English
  Verify File Should Exist In Downloading Folder  ${DOWNLOAD_DIR}  ${NAME_FILE}
  [Teardown]  Close All Browsers
