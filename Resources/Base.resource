*** Settings ***
Documentation   Base
Resource  Keywords//Common.resource


*** Keywords ***
Suite Setup Base
  [Arguments]  ${SPEED_SELENIUM}=0.010  ${TIMEOUT_SELENIUM}=04  ${IMPLICIT_WAIT_SELENIUM}=10  ${LOG_LEVEL}=DEBUG
  [Documentation]  Suite Setup Base
  Set Import Library
  Set Suite Selenium Time And Log Level  ${SPEED_SELENIUM}  ${TIMEOUT_SELENIUM}  ${IMPLICIT_WAIT_SELENIUM}  ${LOG_LEVEL}
  ####  Started suite test
  ${Time}  BuiltIn.Get Time
  Log  ${Time}  console=True
  Set Tags  ${Time} ${SUITE_NAME}

Set Suite Selenium Time And Log Level
  [Arguments]  ${SPEED_SELENIUM}=0.010  ${TIMEOUT_SELENIUM}=04  ${IMPLICIT_WAIT_SELENIUM}=10  ${LOG_LEVEL}=DEBUG
  [Documentation]  Suite Setup Base
  SeleniumLibrary.Set Selenium Speed  ${SPEED_SELENIUM}
  SeleniumLibrary.Set Selenium Timeout  ${TIMEOUT_SELENIUM}
  SeleniumLibrary.Set Selenium Implicit Wait  ${IMPLICIT_WAIT_SELENIUM}
  BuiltIn.Set Log Level  ${LOG_LEVEL}
  Set Suite Variable  ${SPEED_SELENIUM}
  Set Suite Variable  ${TIMEOUT_SELENIUM}
  Set Suite Variable  ${IMPLICIT_WAIT_SELENIUM}
  Set Suite Variable  ${LOG_LEVEL}

Set Import Library
  [Documentation]  Import Library
  Import Library  SeleniumLibrary
  Import Library  BuiltIn
  Import Library  Collections
  Import Library  DateTime
  Import Library  OperatingSystem
  Import Library  Process
  Import Library  String
  Import Library  Screenshot
  Import Library  XML
