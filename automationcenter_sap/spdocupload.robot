*** Settings ***
Test Teardown     Run Keyword If Test Failed    update automationcenter failure    ${TEST MESSAGE}
Library           SSHLibrary
Library           AutomationCenter
Library           WindowsAE
Library           lib\\custom_library.py
Library           SeleniumLibrary
Library           String
Library           BuiltIn
Library           Collections
Library           lib\\traversetoExcel.py
Library           lib\\support.py

*** Variables ***
#input
${aeuser}         ${EMPTY}
${aeparameters}    ${EMPTY}
${aeci}           ${EMPTY}
${aepassword}     ${EMPTY}
${aeprivatekey}    ${EMPTY}
${aedatastore}    ${EMPTY}
${timeout}        NONE
#result
${output}         ""
${error}          ""
${rc}             0
${sapusername}    abwkxzz
${sppassword}     MIIF15F01@97KD
${sapurl}         http://sapgqy501.mmm.com:50000/sourcing/fsbuyer/contracts/contracts_lineitems,644743169:1004
${browser}        edge

*** Test Cases ***
SAPtask
    [Timeout]    ${timeout}
    Log In

*** Keywords ***
Log In
    ####    Login into the SCAS Application
    ${list}=    Create List    --inprivate
    ${args}=    Create Dictionary    args=${list}
    ${desired caps}=    Create Dictionary    ms:edgeOptions=${args}
    Open Browser    ${sapurl}    ${browser}    desired_capabilities=${desired caps}    remote_url=http://localhost:9515
    Maximize Browser Window
    ${valueList} =    Create List
    set global variable    ${valueList}
    Wait Until Page Contains Element    //*[@id="logonuidfield"]
    Input Text    //*[@id="logonuidfield"]    ${sapusername}
    Input Text    //*[@id="logonpassfield"]    ${sppassword}
    Click Element    //*[@name="uidPasswordLogon"]
    Wait Until Page Contains Element    //*[@class="TabText"]
    Click Element    //*[@class="TabText"]
    Wait Until Page Contains Element    //*[@id="selected_entry"]
    Click Element    //*[@id="selected_entry"]/option[4]
    Wait Until Page Contains Element    //*[contains(text(),"Displaying")]
    ${pageCount}=    Get Text    //*[@class="documentToolbarText"][contains(text(),"of")][1]
    ${pageCount}=    Page Count    ${pageCount}
    FOR    ${i}    IN RANGE    ${pageCount}
        Wait Until Page Contains Element    //*[contains(text(),"Displaying")]
        ${GetRange}=    Get Text    //*[contains(text(),"Displaying")]
        ${endRange}=    Make Range    ${GetRange}
        Set Global Variable    ${endRange}
        IndividualValue
        Run Keyword if    '${${i}+1}'!='${pagecount}'    Click Element    //*[@class="nextLink nextLinkUp"]
        sleep    3
        Click Element    //*[@class="TabTextBold"]
        sleep    3
    #log to console    ${i}
    END
    log to console    ${valueList}

IndividualValue
    FOR    ${i}    IN RANGE    ${endRange}
        ${iValue}=    Get Text    //*[@class="queryResultTable"]/tbody/tr[${${i}+1}]/td[1]
        #log to console    ${iValue}
        Append To List    ${valueList}    ${iValue}
        Wait Until Page Contains Element    //*[@class="queryResultTable"]/tbody
    END
    datasettransfer    ${valueList}    //acprd01//E//3M_CAC//SOGS//masterAgreementID.xlsx
