*** Settings ***
Resource          ResourceFile.txt

*** Test Cases ***
Enrollment_RTI_DELETE
    [Tags]    Enrollment_Test_Delete
    : FOR    ${rownum}    IN RANGE    1    ${Countofrecordsinfilefordelete}+1
    \    ${R}    Convert To Integer    ${rownum}
    \    ${resultRow}    Read Cell Value By Row    ${App_RTI_Data_File_Delete}    ${R}
    \    @{resultRow1}    Create List    ${resultRow}
    \    @{Keys}    Get Dictionary Keys    ${resultRow}
    \    ${RTI_Enroll}    RTIgenerator    ${resultRow}    @{Keys}
    \    log    ${RTI_Enroll}
    \    ${request}=    set variable    <S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"><S:Header><BasicAuth><Name>${useridSU}</Name><Password>${passwordSU}</Password></BasicAuth></S:Header><S:Body><ns2:InsertRequest xmlns:ns2="http://campaigncentral.west.com/soap-api/rtinsert"><Format>${Enrollment_Format}</Format><Records><ns2:KVPRecord>${RTI_Enroll}</ns2:KVPRecord></Records></ns2:InsertRequest></S:Body></S:Envelope>
    \    Sleep    2s
    \    Create Http Context    ${CC_URL}    ${https_http}
    \    Set Request Header    Content-Type    text/xml
    \    Set Request Body    ${request}
    \    log    ${RTI_Method}
    \    Sleep    2s
    \    HttpLibrary.HTTP.POST    ${RTI_Method}
    \    ${status_code}=    Get Response Status
    \    Response Body should Contain    success="1"
    \    log Response Body
    BuiltIn.sleep    150s

Test_Data_Cleanup_Camp_Format
    [Tags]    Format_Cleanup
    ${connection}    Jdbc Connect    ${DB_Host}    ${DB_Port}    ${DB_Name}    ${DB_Host}    ${DB_Username}
    ...    ${DB_Password}
    : FOR    ${rownum}    IN RANGE    1    ${Countofrecordsinfile}+1
    \    ${R}    Convert To Integer    ${rownum}
    \    ${resultRow}    Read Cell Value By Row    ${Data_Cleanup_File}    ${R}
    \    log    ${resultRow}
    \    ${Keys}    Get Dictionary Keys    ${resultRow}
    \    ${PhoneNumber_Value}    Get From Dictionary    ${resultRow}    ${Phone_Number}
    \    log    ${PhoneNumber_Value}
    \    ${NotificationType_Value}    Get From Dictionary    ${resultRow}    ${Notifi_type}
    \    log    ${NotificationType_Value}
    \    ${MessageId_Value}    Get From Dictionary    ${resultRow}    ${MessageId}
    \    log    ${MessageId_Value}
    \    ${cursor}    Jdbc Query    ${connection}    set isolation dirty read;
    \    ${cursor}    Jdbc Query    ${connection}    DELETE FROM ${Camp_Format} WHERE ${Camp_Format_Column1} = '${PhoneNumber_Value}' AND ${Camp_Format_Column2} = '${NotificationType_Value}' AND ${Camp_Format_Column3} = '${MessageId_Value}'
    \    ${row}=    Set Variable    0.0
    \    ${cursor}    Jdbc Query    ${connection}    SELECT COUNT(*) from ${Camp_Format} WHERE ${Camp_Format_Column1} = '${PhoneNumber_Value}' AND ${Camp_Format_Column2} = '${NotificationType_Value}' AND ${Camp_Format_Column3} = '${MessageId_Value}'
    \    ${DB_RowCount}    Jdbc Result    ${cursor}
    \    ${rowCount}    Convert To String    ${DB_RowCount}
    \    ${noOfRow}    Get Substring    ${rowCount}    17    -2
    \    Run Keyword If    '${noOfRow}' == '${row}'    log    Cleared data for ${PhoneNumber_Value} from ${Camp_Format} table in database
    \    ...    ELSE    log    Failed to clear data for ${PhoneNumber_Value} from ${Camp_Format} table in database
    Jdbc Release    ${cursor}
    Jdbc Disconnect    ${connection}

    
Validate_NO_PREFERENCE
    [Tags]    Pref1
    : FOR    ${rownum}    IN RANGE    1    ${Countofrecordsinfile}+1
    \    ${R}    Convert To Integer    ${rownum}
    \    ${resultRow}    Read Cell Value By Row    ${App_RTI_Data_File}    ${R}
    \    log    ${resultRow}
    \    ${Keys}    Get Dictionary Keys    ${resultRow}
    \    ${ReceiverId_Value}    Get From Dictionary    ${resultRow}    ${ReceiverId}
    \    log    ${ReceiverId_Value}
    \    ${a}    Convert To String    ${ReceiverId_Value}
    \    ${PreferenceType_Value}    Get From Dictionary    ${resultRow}    ${PreferenceType}
    \    log    ${PreferenceType_Value}
    \    ${ContactPointMethod_Value}    Get From Dictionary    ${resultRow}    ${ContactPointMethod}
    \    log    ${ContactPointMethod_Value}
    \    ${ContactPointName_Value}    Get From Dictionary    ${resultRow}    ${ContactPointName}
    \    log    ${ContactPointName_Value}
    \    ${ContactPointValue_Value}    Get From Dictionary    ${resultRow}    ${ContactPointValue}
    \    log    ${ContactPointValue_Value}
    \    ${VerifyGroup_Value}    Get From Dictionary    ${resultRow}    ${VerifyGroup}
    \    log    ${VerifyGroup_Value}
    \    ${UserId_Value}    Get From Dictionary    ${resultRow}    ${UserId}
    \    log    ${UserId_Value}
    \    Sleep    15s
    \    Create Http Context    ${Pref_Host}    http
    \    Set Request Header    Content-Type    application/json
    \    Set basic Auth    ${Pref_Username}    ${Pref_Password}
    \    Set Request Body    {"token":"07de2cac-e4f0-4090-9648-ad38806ef38d", "userId":"${UserId_Value}", "receiverId":"${ReceiverId_Value}"}
    \    HttpLibrary.HTTP.POST    /prefchoice-api-v3/rest/Preferences/Get.json
    \    Get Response Status
    \    Get Response Body
    \    log Response Body
    \    Response Body Should Contain    "resultCode":100,"resultMessage":"Invalid user"
    \    Response Body Should Contain    preferences":[]

Enrollment_RTI
    [Tags]    Enrollment_Test
    : FOR    ${rownum}    IN RANGE    1    ${Countofrecordsinfile}+1
    \    ${R}    Convert To Integer    ${rownum}
    \    ${resultRow}    Read Cell Value By Row    ${App_RTI_Data_File}    ${R}
    \    @{resultRow1}    Create List    ${resultRow}
    \    @{Keys}    Get Dictionary Keys    ${resultRow}
    \    ${RTI_Enroll}    RTIgenerator    ${resultRow}    @{Keys}
    \    log    ${RTI_Enroll}
    \    ${request}=    set variable    <S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"><S:Header><BasicAuth><Name>${useridSU}</Name><Password>${passwordSU}</Password></BasicAuth></S:Header><S:Body><ns2:InsertRequest xmlns:ns2="http://campaigncentral.west.com/soap-api/rtinsert"><Format>${Enrollment_Format}</Format><Records><ns2:KVPRecord>${RTI_Enroll}</ns2:KVPRecord></Records></ns2:InsertRequest></S:Body></S:Envelope>
    \    Sleep    2s
    \    Create Http Context    ${CC_URL}    ${https_http}
    \    Set Request Header    Content-Type    text/xml
    \    Set Request Body    ${request}
    \    log    ${RTI_Method}
    \    Sleep    2s
    \    HttpLibrary.HTTP.POST    ${RTI_Method}
    \    ${status_code}=    Get Response Status
    \    Response Body should Contain    success="1"
    \    log Response Body
    BuiltIn.sleep    150s

ValidateEnrollmentlPreprocessors
    [Tags]    Enrollment_Preprocessor_Validation
    SSHLibrary.Open Connection    ${Loader_Server}    timeout=1 hour
    Comment    SSHLibrary.Enable SSH Logging    ${SSH_Log}
    SSHLibrary.Login With Public Key    wicqacip    ${RSA_Key}
    ${Current_Time}    Get Current Date    local
    ${C_Time}    Add Time To Date    ${Current_Time}    -.29 hours
    ${Start_time}    Get Substring    ${C_Time}    11    -7
    ${E_Time}    Add Time To Date    ${Current_Time}    +0.19 hours
    ${End_time}    Get Substring    ${E_Time}    11    -7
    Sleep    1m
    Start Command    grep \ "${Preprocessor_StoreInfo}" ${LoaderLogs} | awk -v from="${Start_Time}" -v to="${End_Time}" '$1>=from && $1<=to'
    ${std_output}=    Read Command Output
    Should Contain    ${std_output}    ${Preprocessor_StoreInfo}
    Log    ${std_output}

Validate_Recoords_Insertion_in_DB
    [Tags]    SanityTest_DB
    Sleep    120s
    ${connection}    Jdbc Connect    ${DB_Host}    ${DB_Port}    ${DB_Name}    ${DB_Host}    ${DB_Username}
    ...    ${DB_Password}
    : FOR    ${rownum}    IN RANGE    1    ${Countofrecordsinfile}+1
    \    ${R}    Convert To Integer    ${rownum}
    \    ${resultRow}    Read Cell Value By Row    ${Data_Cleanup_File}    ${R}
    \    log    ${resultRow}
    \    ${Keys}    Get Dictionary Keys    ${resultRow}
    \    ${PhoneNumber_Value}    Get From Dictionary    ${resultRow}    ${Phone_Number}
    \    log    ${PhoneNumber_Value}
    \    ${NotificationType_Value}    Get From Dictionary    ${resultRow}    ${Notifi_type}
    \    log    ${NotificationType_Value}
    \    ${MessageId_Value}    Get From Dictionary    ${resultRow}    ${MessageId}
    \    log    ${MessageId_Value}
    \    ${cursor}    Jdbc Query    ${connection}    set isolation dirty read;
    \    ${cursor}    Jdbc Query    ${connection}    SELECT send_status FROM ${Camp_Format} WHERE ${Camp_Format_Column1} = '${PhoneNumber_Value}' AND ${Camp_Format_Column2} = '${NotificationType_Value}' AND ${Camp_Format_Column3} = '${MessageId_Value}'
    \    ${DB_Result}    Jdbc Result    ${cursor}
    \    ${rersult_String}    Convert to String    ${DB_Result}
    \    ${resultString}    Get Substring    ${rersult_String}    18    -2
    \    ${row}=    Set Variable    1.0
    \    ${cursor}    Jdbc Query    ${connection}    SELECT COUNT(*) from ${Camp_Format} WHERE ${Camp_Format_Column1} = '${PhoneNumber_Value}' AND ${Camp_Format_Column2} = '${NotificationType_Value}' AND ${Camp_Format_Column3} = '${MessageId_Value}'
    \    ${DB_RowCount}    Jdbc Result    ${cursor}
    \    ${rowCount}    Convert To String    ${DB_RowCount}
    \    ${noOfRow}    Get Substring    ${rowCount}    17    -2
    \    Run Keyword If    '${noOfRow}' == '${row}'    log    Record inserted for ${PhoneNumber_Value} in ${Camp_Format} table in database
    \    ...    ELSE    log    Failed to insert record for ${PhoneNumber_Value} in ${Camp_Format} table in database
    \    ${message}    Set Variable    ${resultString}
    \    ${send_status}=    Set Variable    4
    \    ${send_status1}=    Set Variable    5
    \    ${send_status2}=    Set Variable    7
    \    Run Keyword If    '${message}' < '${send_status}'    log    Message status is "incomplete" for ${PhoneNumber_Value}
    \    ...    ELSE    Log    Continue For Loop
    \    Run Keyword If    '${message}' == '${send_status}'    log    Message status is "Completed Failed" for ${PhoneNumber_Value}
    \    ...    ELSE    Log    Continue For Loop
    \    Run Keyword If    '${message}' == '${send_status2}'    log    Call has not been initiated and ${PhoneNumber_Value} is on DNC list/ Not on Calling Window
    \    ...    ELSE    Log    Continue For Loop
    \    Run Keyword If    '${message}' == '${send_status1}'    log    Message status is "Completed Success" for ${PhoneNumber_Value} and Message successfully sent to ${PhoneNumber_Value}
    \    ...    ELSE    Log    ${PhoneNumber_Value} is "Not Allocated" to call
    Jdbc Release    ${cursor}
    Jdbc Disconnect    ${connection}


Bypasscodes_Validation_CSV
    [Tags]    BypasscodesValidation
    ${connection}    Jdbc Connect    ${DB_Host}    ${DB_Port}    ${DB_Name}    ${DB_Host}    ${DB_Username}
    ...    ${DB_Password}
    : FOR    ${rownum}    IN RANGE    1    ${Countofrecordsinfile}+1
    \    ${R}    Convert To Integer    ${rownum}
    \    ${resultRow}    Read Cell Value By Row    ${Data_Cleanup_File}    ${R}
    \    log    ${resultRow}
    \    ${Keys}    Get Dictionary Keys    ${resultRow}
    \    ${PhoneNumber_Value}    Get From Dictionary    ${resultRow}    ${Phone_Number}
    \    log    ${PhoneNumber_Value}
    \    ${NotificationType_Value}    Get From Dictionary    ${resultRow}    ${Notifi_type}
    \    log    ${NotificationType_Value}
    \    ${MessageId_Value}    Get From Dictionary    ${resultRow}    ${MessageId}
    \    log    ${MessageId_Value}
    \    ${Bypasscode_Value}    Get From Dictionary    ${resultRow}    ${bypasscode}
    \    log    ${Bypasscode_Value}
    \    ${cursor}    Jdbc Query    ${connection}    set isolation dirty read
    \    ${cursor}    Jdbc Query    ${connection}    SELECT ${Bypasscode_Column_Name} FROM ${Camp_Format} WHERE ${Camp_Format_Column1} = '${PhoneNumber_Value}' AND ${Camp_Format_Column2} = '${NotificationType_Value}' AND ${Camp_Format_Column3} = '${MessageId_Value}'
    \    ${DB_Results}    Jdbc Result    ${cursor}
    \    ${queryResults}    Convert to String    ${DB_Results}
    \    Log    ${queryResults}
    \    ${resultString}    Get Substring    ${queryResults}    19    -3
    \    log    ${resultString}
    \    ${BypassCode_Status}    Set Variable    ${resultString}
    \    ${BypassCode_Success}=    Set Variable    ${Bypasscode_Value}
    \    ${BypassCode_Duplicate}=    Set Variable    B004
    \    ${BypassCode_Wrong_Contact_Date}=    Set Variable    B020
    \    Run Keyword If    '${BypassCode_Status}' == '${BypassCode_Wrong_Contact_Date}'    log    Message status is "Wrong Contact Date" for ${PhoneNumber_Value} and Bypasscode did not match for ${PhoneNumber_Value}
    \    ...    ELSE    Log    Continue For Loop
    \    Run Keyword If    '${BypassCode_Status}' == '${BypassCode_Duplicate}'    log    Message status is "Duplicates Records" for ${PhoneNumber_Value} and Bypasscode did not match for ${PhoneNumber_Value}
    \    ...    ELSE    Log    Continue For Loop
    \    Run Keyword If    '${BypassCode_Status}' == '${BypassCode_Success}'    log    Bypasscode matched for ${PhoneNumber_Value}
    \    ...    ELSE    Log    ${PhoneNumber_Value} is "Not Allocated" to call
    \    Log    "More info about bypasscode ,please see the link: ${BypassCodelink}"
    Jdbc Release    ${cursor}
    Jdbc Disconnect    ${connection}

	
SMS_Message_Content_validation_ORR_WM
    [Tags]    SanityTest_SMS_Content
    ${connection}    Jdbc Connect    ${WIMP_DB_HOST}    ${WIMP_DB_PORT}    ${WIMP_DB_NAME}    ${WIMP_DB_HOST}    ${WIMP_DB_USERNAME}
    ...    ${WIMP_DB_PASSWORD}
    ${date1}    Get Current Date
    ${date}    Convert Date    ${date1}    exclude_millis=yes
    ${FutureDate1}    Add Time To Date    ${date1}    .10 hours
    ${FutureDate}    Convert Date    ${FutureDate1}    exclude_millis=yes
    : FOR    ${rownum}    IN RANGE    1    ${Countofrecordsinfile}+1
    \    ${R}    Convert To Integer    ${rownum}
    \    ${resultRow}    Read Cell Value By Row    ${Data_File}    ${R}
    \    ${RecipientPhoneNumber}    Get From Dictionary    ${resultRow}    ${Phone_Number}
    \    ${Verbiage}    Get From Dictionary    ${resultRow}    Verbiage
    \    ${Verbiage2}    Convert To String    ${Verbiage}
    \    ${cursor}    Jdbc Query    ${connection}    select first 1 message from wimp_sent where mobile_number = '001${RecipientPhoneNumber}' AND message LIKE '${Client_name_wimp}' order by received desc
    \    ${DB_Results}    jdbc_result    ${cursor}
    \    ${queryResultsNew2}    Convert To String    ${DB_Results}
    \    ${queryResultsNew3}    Get Substring    ${queryResultsNew2}    16    -4
    \    ${a}=    Strip String    ${queryResultsNew3}    mode=right
    \    log    ${a}
    \    Run Keyword If    "'${a}'" == "'${Verbiage2}'"    log    Verbiage matched for ${RecipientPhoneNumber}
    \    ...    ELSE    log    Verbiage did not match for ${RecipientPhoneNumber}
    Jdbc Release    ${cursor}
    Jdbc Disconnect    ${connection}

Checking_2Way-SMS-Verbiage
    [Tags]    SanityTest_2_Way_SMS_1
    : FOR    ${rownum}    IN RANGE    1    ${Countofrecordsinfile}+1
    \    ${R}    Convert To Integer    ${rownum}
    \    ${resultRow}    read_cell_value_by_row    ${Data_File}    ${R}
    \    ${mobile}    Get From Dictionary    ${resultRow}    ContactPointValue
    \    ${apn}    Get From Dictionary    ${resultRow}    APN
    \    ${smscode}    Get From Dictionary    ${resultRow}    SHORTCODE
    \    ${Keyword1}    Get From Dictionary    ${resultRow}    Keyword1
    \    ${Keyword2}    Get From Dictionary    ${resultRow}    Keyword2
    \    ${Keyword3}    Get From Dictionary    ${resultRow}    Keyword3
    \    ${Message1}    Get From Dictionary    ${resultRow}    Message1
    \    ${Message2}    Get From Dictionary    ${resultRow}    Message2
    \    ${Message3}    Get From Dictionary    ${resultRow}    Message3
    \    ${a}=    set variable    ${MOHandler_URL}&apn=${apn}&smscode=${smscode}&mobile=${mobile}&message=
    \    log    ${a}${Keyword1}
    \    ${Pass1}    Run Keyword If    '${Keyword1}' != '${EMPTY}'    Get Short Url    ${a}${Keyword1}
    \    ...    ELSE    Continue For Loop
    \    log    ${Pass1}
    \    ${Pass10}=    Fetch From Right    ${Pass1}    REPLY:
    \    ${a1}=    Fetch From Left    ${Pass10}    MT
    \    ${a9}=    Strip String    ${a1}    mode=right
    \    log    ${a9}
    \    Run Keyword If    "'${a9}'" == "'${Message1}'"    log    Verbiage matched for ${Message1}
    \    ...    ELSE    log    Verbiage did not match for ${Message1}
    \    BuiltIn.Sleep    5s
    \    ${Pass2}    Run Keyword If    '${Keyword2}' != '${EMPTY}'    Get Short Url    ${a}${Keyword2}
    \    ...    ELSE    Continue For Loop
    \    log    ${Pass2}
    \    ${Pass20}=    Fetch From Right    ${Pass2}    REPLY:
    \    ${a2}=    Fetch From Left    ${Pass20}    MT
    \    ${a3}=    Strip String    ${a2}    mode=right
    \    log    ${a3}
    \    Run Keyword If    "'${a3}'" == "'${Message2}'"    log    Verbiage matched for ${Message2}
    \    ...    ELSE    log    Verbiage did not match for ${Message2}
    \    BuiltIn.Sleep    5s
    \    ${Pass3}    Run Keyword If    '${Keyword3}' != '${EMPTY}'    Get Short Url    ${a}${Keyword3}
    \    ...    ELSE    Continue For Loop
    \    log    ${Pass3}
    \    ${Pass30}=    Fetch From Right    ${Pass3}    REPLY:
    \    ${a4}=    Fetch From Left    ${Pass30}    MT
    \    ${a5}=    Strip String    ${a4}    mode=right
    \    log    ${a5}
    \    Run Keyword If    "'${a5}'" == "'${Message3}'"    log    Verbiage matched for ${Message3}
    \    ...    ELSE    log    Verbiage did not match for ${Message3}
    BuiltIn.sleep    200s
    
GET_PREFERENCE
    [Tags]    Pref2
    : FOR    ${rownum}    IN RANGE    1    ${Countofrecordsinfile}+1
    \    ${R}    Convert To Integer    ${rownum}
    \    ${resultRow}    Read Cell Value By Row    ${App_RTI_Data_File}    ${R}
    \    log    ${resultRow}
    \    ${Keys}    Get Dictionary Keys    ${resultRow}
    \    ${ReceiverId_Value}    Get From Dictionary    ${resultRow}    ${ReceiverId}
    \    log    ${ReceiverId_Value}
    \    ${a}    Convert To String    ${ReceiverId_Value}
    \    ${PreferenceType_Value}    Get From Dictionary    ${resultRow}    ${PreferenceType}
    \    log    ${PreferenceType_Value}
    \    ${ContactPointMethod_Value}    Get From Dictionary    ${resultRow}    ${ContactPointMethod}
    \    log    ${ContactPointMethod_Value}
    \    ${ContactPointName_Value}    Get From Dictionary    ${resultRow}    ${ContactPointName}
    \    log    ${ContactPointName_Value}
    \    ${ContactPointValue_Value}    Get From Dictionary    ${resultRow}    ${ContactPointValue}
    \    log    ${ContactPointValue_Value}
    \    ${VerifyGroup_Value}    Get From Dictionary    ${resultRow}    ${VerifyGroup}
    \    log    ${VerifyGroup_Value}
    \    ${UserId_Value}    Get From Dictionary    ${resultRow}    ${UserId}
    \    log    ${UserId_Value}
    \    Sleep    15s
    \    Create Http Context    ${Pref_Host}    http
    \    Set Request Header    Content-Type    application/json
    \    Set basic Auth    ${Pref_Username}    ${Pref_Password}
    \    Set Request Body    {"token":"07de2cac-e4f0-4090-9648-ad38806ef38d", "userId":"${UserId_Value}", "receiverId":"${ReceiverId_Value}"}
    \    HttpLibrary.HTTP.POST    /prefchoice-api-v3/rest/Preferences/Get.json
    \    Get Response Status
    \    Get Response Body
    \    log Response Body
    \    Response Body Should Contain    "resultCode":0,"resultMessage":"Success"
    \    Response Body Should Contain    preferences":[{"receiverId":"${ReceiverId_Value}","preferenceType":"${PreferenceType_Value}"
    \    Response Body Should Contain    contactPoint":{"name":"${ContactPointName_Value}","method":"${ContactPointMethod_Value}","value":"${ContactPointValue_Value}"
    \    Response Body Should Contain    "verifyGroups":[{"name":"${VerifyGroup_Value}"
    \    #Response Body Should Contain    {"resultCode":0,"resultMessage":"Success","preferences":[{"receiverId":"${ReceiverId_Value}","preferenceType":"${PreferenceType_Value}","contactMethod":"${ContactPointMethod_Value}","contactPoint":{"name":"${ContactPointName_Value}","method":"${ContactPointMethod_Value}","value":" ${ContactPointValue_Value} ","verifyGroups":[{"name":"${VerifyGroup_Value}"}]}}]}"
