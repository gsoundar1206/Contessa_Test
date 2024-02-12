*** Settings ***
Resource          ResourceFile.txt

*** Test Cases ***
Test_Data_Cleanup_Enrollment
    [Tags]    Enrollment_Cleanup
    ${connection}    Jdbc Connect    ${DB_Host}    ${DB_Port}    ${DB_Name}    ${DB_Host}    ${DB_Username}
    ...    ${DB_Password}
    ${connection1}    Jdbc Connect    ${WIMP_DB_HOST}    ${WIMP_DB_PORT}    ${WIMP_DB_NAME}    ${WIMP_DB_HOST}    ${WIMP_DB_USERNAME}
    ...    ${WIMP_DB_PASSWORD}
    : FOR    ${rownum}    IN RANGE    1    ${Countofrecordsinfile}+1
    \    ${R}    Convert To Integer    ${rownum}
    \    ${resultRow}    Read Cell Value By Row    ${Data_Cleanup_File}    ${R}
    \    log    ${resultRow}
    \    ${Keys}    Get Dictionary Keys    ${resultRow}
    \    ${PhoneNumber_Value}    Get From Dictionary    ${resultRow}    ${Phone_Number}
    \    log    ${PhoneNumber_Value}
    \    ${ContactPointMethod_Value}    Get From Dictionary    ${resultRow}    ${Contact_Method}
    \    log    ${ContactPointMethod_Value}
    \    ${PatientId_Value}    Get From Dictionary    ${resultRow}    ${PatientId}
    \    log    ${PatientId_Value}
    \    ${NotificationType_Value}    Get From Dictionary    ${resultRow}    ${Notifi_type}
    \    log    ${NotificationType_Value}
    \    ${PreferenceType_Value}    Get From Dictionary    ${resultRow}    ${Pref_type}
    \    log    ${PreferenceType_Value}
    \    ${MessageId_Value}    Get From Dictionary    ${resultRow}    ${MessageId}
    \    log    ${MessageId_Value}
    \    ${cursor}    Jdbc Query    ${connection}    set isolation dirty read;
    \    ${cursor}    Jdbc Query    ${connection}    DELETE FROM ${Enrollment_Format} WHERE ${Enrollment_Format_Column1} = '${PhoneNumber_Value}' AND ${Enrollment_Format_Column2} = '${ContactPointMethod_Value}' AND ${Enrollment_Format_Column3} = '${PreferenceType_Value}'
    \    ${row}=    Set Variable    0.0
    \    ${cursor}    Jdbc Query    ${connection}    SELECT COUNT(*) from ${Enrollment_Format} WHERE ${Enrollment_Format_Column1} = '${PhoneNumber_Value}' AND ${Enrollment_Format_Column2} = '${ContactPointMethod_Value}' AND ${Enrollment_Format_Column3} = '${PreferenceType_Value}'
    \    ${DB_RowCount}    Jdbc Result    ${cursor}
    \    ${rowCount}    Convert To String    ${DB_RowCount}
    \    ${noOfRow}    Get Substring    ${rowCount}    17    -2
    \    Run Keyword If    '${noOfRow}' == '${row}'    log    Cleared data for ${PhoneNumber_Value} from ${Enrollment_Format } table in database
    \    ...    ELSE    log    Failed to clear data for ${PhoneNumber_Value} from ${Enrollment_Format } table in database
    \    ${cursor1}    Jdbc Query    ${connection}    set isolation dirty read;
    \    ${cursor1}    Jdbc Query    ${connection}    DELETE FROM ${Camp_Format} WHERE ${Camp_Format_Column1} = '${PhoneNumber_Value}' AND ${Camp_Format_Column2} = '${NotificationType_Value}' AND ${Camp_Format_Column3} = '${MessageId_Value}'
    \    ${row1}=    Set Variable    0.0
    \    ${cursor1}    Jdbc Query    ${connection}    SELECT COUNT(*) from ${Camp_Format} WHERE ${Camp_Format_Column1} = '${PhoneNumber_Value}' AND ${Camp_Format_Column2} = '${NotificationType_Value}' AND ${Camp_Format_Column3} = '${MessageId_Value}'
    \    ${DB_RowCount1}    Jdbc Result    ${cursor1}
    \    ${rowCount1}    Convert To String    ${DB_RowCount1}
    \    ${noOfRow1}    Get Substring    ${rowCount1}    17    -2
    \    Run Keyword If    '${noOfRow1}' == '${row1}'    log    Cleared data for ${PhoneNumber_Value} from ${Camp_Format} table in database
    \    ...    ELSE    log    Failed to clear data for ${PhoneNumber_Value} from ${Camp_Format} table in database
    \    ${cursor2}    Jdbc Query    ${connection1}    set isolation dirty read
    \    ${cursor2}    Jdbc Query    ${connection1}    DELETE FROM ${Wimp_Table} WHERE ${Wimp_Table_Column1} = '001${PhoneNumber_Value}'
    \    ${row2}=    Set Variable    0.0
    \    ${cursor2}    Jdbc Query    ${connection1}    SELECT COUNT(*) FROM ${Wimp_Table} WHERE ${Wimp_Table_Column1} = '001${PhoneNumber_Value}'
    \    ${DB_RowCount2}    Jdbc Result    ${cursor2}
    \    ${rowCount2}    Convert To String    ${DB_RowCount2}
    \    ${noOfRow2}    Get Substring    ${rowCount2}    17    -2
    \    Run Keyword If    '${noOfRow2}' == '${row2}'    log    Cleared data for ${PhoneNumber_Value} from ${Wimp_Table} table in database
    \    ...    ELSE    log    Failed to clear data for ${PhoneNumber_Value} from ${Wimp_Table} table in database
    Jdbc Release    ${cursor}
    Jdbc Release    ${cursor1}
    Jdbc Release    ${cursor2}
    Jdbc Disconnect    ${connection}
    Jdbc Disconnect    ${connection1}

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

Enrollment_RTI
    [Tags]    Enrollment_Test
    : FOR    ${rownum}    IN RANGE    1    ${Countofrecordsinfile}+1
    \    ${R}    Convert To Integer    ${rownum}
    \    ${resultRow}    Read Cell Value By Row    ${Enrollment_Data_File}    ${R}
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
    \    HttpLibrary.HTTP.POST    ${RTI_Method}
    \    ${status_code}=    Get Response Status
    \    Response Body should Contain    success="1"
    \    Sleep    5s
    \    log Response Body

ValidateEnrollmentlPreprocessors
    [Tags]    Enrollment_Preprocessor_Validation
    SSHLibrary.Open Connection    ${Loader_Server}    timeout=1 hour
    Comment    SSHLibrary.Enable SSH Logging    ${SSH_Log}
    SSHLibrary.Login With Public Key    wicqacip    ${RSA_Key}
    ${Current_Time}    Get Current Date    local
    ${C_Time}    Add Time To Date    ${Current_Time}    -.19 hours
    ${Start_time}    Get Substring    ${C_Time}    11    -7
    ${E_Time}    Add Time To Date    ${Current_Time}    +0.01 hours
    ${End_time}    Get Substring    ${E_Time}    11    -7
    Sleep      ${Enroll_Preprocessor_Timer}
    Start Command    /usr/local/bin/log_seek ${LoaderLogs} '^[0-9][0-9]:[0-9][0-9]' '${Start_Time}:' \ '${End_Time}:' | grep "${Preprocessor_StoreInfo}"
    ${std_output}=    Read Command Output
    Should Contain    ${std_output}    ${Preprocessor_StoreInfo}
    Log    ${std_output}

Enrollment_Validations
    [Tags]    Enrollment_Test
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
    \    ${ContactPointMethod_Value}    Get From Dictionary    ${resultRow}    ${Contact_Method}
    \    log    ${ContactPointMethod_Value}
    \    ${PreferenceType_Value}    Get From Dictionary    ${resultRow}    ${Pref_type}
    \    log    ${PreferenceType_Value}
    \    ${row}=    Set Variable    1.0
    \    ${row3}=    Set Variable    0.0
    \    ${row2}=    Set Variable    2.0
    \    ${cursor}    Jdbc Query    ${connection}    set isolation dirty read;
    \    #${cursor}    Jdbc Query    ${connection}    SELECT sendtoservice FROM ${Enrollment_Format} WHERE ${Enrollment_Format_Column1} = '${PhoneNumber_Value}' AND ${Enrollment_Format_Column2} = '${ContactPointMethod_Value}' AND ${Enrollment_Format_Column3} = '${PreferenceType_Value}'
    \    ${cursor}    Jdbc Query    ${connection}    SELECT COUNT(*) FROM ${Enrollment_Format} WHERE ${Enrollment_Format_Column1} = '${PhoneNumber_Value}' AND ${Enrollment_Format_Column2} = '${ContactPointMethod_Value}' AND ${Enrollment_Format_Column3} = '${PreferenceType_Value}'
    \    ${DB_RowCount}    Jdbc Result    ${cursor}
    \    Log    ${DB_RowCount}
    \    ${row1}    Convert To String    ${DB_RowCount}
    \    ${rowString}    Convert to String    ${row1}
    \    ${noOfRow}    Get Substring    ${rowString}    17    -2
    \    Run Keyword If    '${noOfRow}' == '${row3}'    log    Record failed to insert for ${PhoneNumber_Value} in ${Enrollment_Format} table in database
    \    ...    ELSE    log    Continue For Loop
    \    Run Keyword If    '${noOfRow}' == '${row}'    log    Record inserted for ${PhoneNumber_Value} and Good Record and Verification needed for ${PhoneNumber_Value}
    \    ...    ELSE    log    Continue For Loop
    \    Run Keyword If    '${noOfRow}' == '${row2}'    log    Record inserted for ${PhoneNumber_Value} and Preference added and Verification needed for ${PhoneNumber_Value} in ${Enrollment_Format} table in database
    \    ...    ELSE    log    Terminate For loop
    Jdbc Release    ${cursor}
    Jdbc Disconnect    ${connection}
    
FTP_File_Drop
    [Tags]    BatchFileTest_CVS
    SSHLibrary.OpenConnection    ${SFTP_Server}
    SSHlibrary.Login    ${SFTP_User}    ${SFTP_Passwd}
    : FOR    ${rownum}    IN RANGE    1    ${NumberofFilestoUpload}+1
    \    ${R}    Convert To Integer    ${rownum}
    \    ${resultRow}    Read Cell Value By Row    ${FTP_Data_File}    ${R}
    \    log    ${resultRow}
    \    ${FilePath}    Get From Dictionary    ${resultRow}    Directory
    \    log    ${FilePath}
    \    ${FileName}    Get From Dictionary    ${resultRow}    UploadFileName
    \    log    ${FileName}
    \    Put File    ${FileName}    ${FilePath}
    \    ${DirectoryList}    SSHLibrary.List Files in Directory    ${FilePath}
    \    Log    ${DirectoryList}
    \    Should Contain    ${DirectoryList}    ${FileName}
    SSHLibrary.Close Connection


    
FTP_File_Drop
    [Tags]    BatchFileTest
    Sftp Connect    ${SFTP_Server}    ${SFTP_User}    ${SFTP_Passwd}
    Sleep    5s
    : FOR    ${rownum}    IN RANGE    1    ${NumberofFilestoUpload}+1
    \    ${R}    Convert To Integer    ${rownum}
    \    ${resultRow}    Read Cell Value By Row    ${FTP_Data_File}    ${R}
    \    log    ${resultRow}
    \    ${FilePath}    Get From Dictionary    ${resultRow}    Directory
    \    log    ${FilePath}
    \    ${FileName}    Get From Dictionary    ${resultRow}    UploadFileName
    \    log    ${FileName}
    \    Drop File    ${FilePath}    ${FileName}
    \    log    "File dropped success"
    Sftp Closeconnection
    
Validate_File_Dropped
    [Tags]    IgnoreTag
    \    Start Command    ls -l ${FilePath}
    \    ${DirectoryList}    Read Command Output
    \    Log    ${DirectoryList}
    \    Should Contain    ${DirectoryList}    ${FileName}
    SSHLibrary.Close Connection


Connect_To_Hub_Server
    [Tags]    BatchFileTest_HUB
    SSHLibrary.Open Connection    ${Hub_Server}    timeout=1 hour
    ${user}    SSHLibrary.Login With Public Key    wicqacip    ${RSA_Key}
    ${server}    Get Substring    ${Hub_Server}    \    9
    ${loginuser}    Set Variable    wicqacip@${Server}
    Should Contain    ${user}    ${loginuser}

ValidatingHubscriptsExecution
    [Tags]      BatchFileTest_HUB
    ${Date}    Get Current Date    local
    ${YYMMDD}    Convert Date    ${Date}    result_format=%y%m%d
    ${Current_Time}    Get Current Date    local
    ${C_Time}    Add Time To Date    ${Current_Time}    -.03 hours
    ${Start_time}    Get Substring    ${C_Time}    11    -7
    ${E_Time}    Add Time To Date    ${Current_Time}    +0.13 hours
    ${End_time}    Get Substring    ${E_Time}    11    -7
    log    ${HubScriptsLogs}
    # Start Command    cd ${HubScriptsLogs}
    : FOR    ${wait_time}    IN RANGE    0    ${Timer}+1
    \    Sleep    60s
    \    Start Command    grep "Uploading the processed file to ${HubScript_processedpath}" ${HubScriptsLogs}_20${YYMMDD}.txt | awk -v from="${Start_Time}" -v to="${End_Time}" '$2>=from && $2<=to'
    \    ${std_out}=    Read Command Output
    \    ${results}    Get Substring    ${std_out}    33
    \    Log    ${Timer}
    \    Run Keyword If    '${results}' == 'Uploading the processed file to ${HubScript_processedpath}'    Exit For Loop
    Start Command    grep "Uploading the processed file to " ${HubScriptsLogs}_20${YYMMDD}.txt | awk -v from="${Start_Time}" -v to="${End_Time}" '$2>=from && $2<=to'
    ${std_output}    Read Command Output
    ${Result2}    Convert To String    ${std_output}
    log    ${Result2}
    Should Contain    ${Result2}    ${HubScript_archivepath}
    Should Contain    ${Result2}    ${HubScript_processedpath}
    : FOR    ${rownum}    IN RANGE    1    ${NumberofFilestoUpload}+1
    \    ${R}    Convert To Integer    ${rownum}
    \    ${resultRow}    Read Cell Value By Row    ${FTP_Data_File}    ${R}
    \    log    ${resultRow}
    \    ${FilePath}    Get From Dictionary    ${resultRow}    Directory
    \    log    ${FilePath}
    \    ${FileName}    Get From Dictionary    ${resultRow}    UploadFileName
    \    log    ${FileName}
    \    Start Command    grep "WARNING" ${HubScriptsLogs}_20${YYMMDD}.txt \ | awk -v from="${Start_Time}" -v to="${End_Time}" '$2>=from && $2<=to' | awk '{print $4}' | \ awk -F/ '{print $NF}'
    \    ${std_output}=    Read Command Output
    \    ${Result3}    Convert To String    ${std_output}
    \    Run Keyword If    '${FileName}' == '${Result3}'    Exit For Loop
    Start Command    grep "Script" ${HubScriptsLogs}_20${YYMMDD}.txt
    ${std_output}=    Read Command Output
    ${Result4}    Convert To String    ${std_output}
    Should Contain    ${Result4}    Script successfully executed!

APP_RTI
    [Tags]    RTI_Test
    : FOR    ${rownum}    IN RANGE    1    ${Countofrecordsinfile}+1
    \    ${R}    Convert To Integer    ${rownum}
    \    ${resultRow}    Read Cell Value By Row    ${App_RTI_Data_File}    ${R}
    \    @{resultRow1}    Create List    ${resultRow}
    \    @{Keys}    Get Dictionary Keys    ${resultRow}
    \    ${RTI_APP}    RTIgenerator    ${resultRow}    @{Keys}
    \    log    ${RTI_APP}
    \    ${request}=    set variable    <S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"><S:Header><BasicAuth><Name>${useridSU}</Name><Password>${passwordSU}</Password></BasicAuth></S:Header><S:Body><ns2:InsertRequest xmlns:ns2="http://campaigncentral.west.com/soap-api/rtinsert"><Format>${Camp_Format}</Format><Records><ns2:KVPRecord>${RTI_APP}</ns2:KVPRecord></Records></ns2:InsertRequest></S:Body></S:Envelope>
    \    Sleep    2s
    \    Create Http Context    ${CC_URL}    ${https_http}
    \    Set Request Header    Content-Type    text/xml
    \    Set Request Body    ${request}
    \    log    ${RTI_Method}
    \    HttpLibrary.HTTP.POST    ${RTI_Method}
    \    ${status_code}=    Get Response Status
    \    Response Status Code Should Equal    200
    \    Response Body should Contain    success
    \    Sleep    5s
    \    log Response Body
    
APP_RTI
    [Tags]    RTI_Test_SDL
    : FOR    ${rownum}    IN RANGE    1    ${Countofrecordsinfile}+1
    \    Create Http Context    linux1055:8000
    \    Set Request Header    accept    text/xml
    \    HttpLibrary.HTTP.GET    /suddenlink/getVars_PREPROD_ONLY.jsp
    \    Response Status Code Should Equal    200
    \    ${res}=    Get Response Body
    \    ${res_str}    Convert To String    ${res}
    \    Log    ${res_str}
    \    ${Date}    Get Substring    ${res_str}    17    55
    \    ${Curr_Date}    Strip String    ${Date}    mode=left
    \    ${Auth_String}    Get Substring    ${res_str}    63    95
    \    ${messageId}    Generate Random String    11    1234
    \    ${R}    Convert To Integer    ${rownum}
    \    ${resultRow}    Read Cell Value By Row    ${App_RTI_Data_File}    ${R}
    \    @{resultRow1}    Create List    ${resultRow}
    \    @{Keys}    Get Dictionary Keys    ${resultRow}
    \    ${RTI_APP}    RTI_GEN    ${resultRow}    @{Keys}
    \    log    ${RTI_APP}
    \    ${request}=    set variable    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:toatech:agent" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Body><ns1:send_message xmlns="urn:toatech:agent"><user><now>${Curr_Date}</now><login>${useridSU}</login><auth_string>${Auth_String}</auth_string></user><messages><message><message_id>${messageId}</message_id><body>${RTI_APP}</body></message></messages></ns1:send_message></soapenv:Body></soapenv:Envelope>
    \    Sleep    2s
    \    Create Http Context    ${CC_URL}    ${https_http}
    \    Set Request Header    Content-Type    text/xml
    \    Set Request Body    ${request}
    \    log    ${RTI_Method}
    \    HttpLibrary.HTTP.POST    ${RTI_Method}
    \    ${status_code}=    Get Response Status
    \    Response Status Code Should Equal    200
    \    log Response Body

ValidatethePreprocessor(Loader)logs
    [Tags]    Preprocessor_Validation
    SSHLibrary.Open Connection    ${Loader_Server}    timeout=1 hour
    Comment    SSHLibrary.Enable SSH Logging    ${SSH_Log}
    SSHLibrary.Login With Public Key    wicqacip    ${RSA_Key}
    Run Keyword if    '${Insert_Method}' == 'batch'    Preprocessor_Batch_Validation
    ...    ELSE    Preprocessor_RTI_Validation
    SSHLibrary.Close Connection

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

Bypass_code_Validation_For_format_bypass_code
    [Tags]    Bypass_codeValidation
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
    \    ${resultString}    Get Substring    ${queryResults}    20    -3
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

ValidatePredialer(Engine)log
    [Tags]    Predialer_Validation
    SSHLibrary.Open Connection    ${Engine_Server}    timeout=1 hour
    Comment    SSHLibrary.Enable SSH Logging    ${SSH_Log}
    SSHLibrary.Login With Public Key    wicqacip    ${RSA_Key}
    ${Current_Time}    Get Current Date    local
    ${C_Time}    Add Time To Date    ${Current_Time}    -.19 hours
    ${Start_time}    Get Substring    ${C_Time}    11    -7
    ${E_Time}    Add Time To Date    ${Current_Time}    +0.01 hours
    ${End_time}    Get Substring    ${E_Time}    11    -7
    Sleep   ${Predialer_Timer}
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
    \    ${cursor}    Jdbc Query    ${connection}    select west_record_id from ${Camp_Format} WHERE ${Camp_Format_Column1} = '${PhoneNumber_Value}' AND ${Camp_Format_Column2} = '${NotificationType_Value}' AND ${Camp_Format_Column3} = '${MessageId_Value}'
    \    ${DB_results}    Jdbc Result    ${cursor}
    \    Log    ${DB_results}
    \    ${Record_Id}    convert to String    ${DB_results}
    \    ${West_Record_Id}    get Substring    ${Record_Id}    21    -2
    \    Start Command    /usr/local/bin/log_seek ${EngineLog} '^[0-9][0-9]:[0-9][0-9]' '${Start_Time}:' '${End_Time}:' | grep "${Predialer_Message} ${West_Record_Id}" | awk -F[ '{print $NF}'
    \    ${std_output}=    Read Command Output
    \    Log    ${std_output}
    \    ${results}     convert to String   ${std_output}
    \    ${predialer_results}       get Substring       ${results}      0       47
    \    Log    ${predialer_results}
    \    Run Keyword If    '${predialer_results}'== '${Predialer_Message} ${West_Record_Id}'    log    "Pass"
    \    ...    ELSE    log    "Fail"
    Jdbc Release    ${cursor}
    Jdbc Disconnect    ${connection}
    SSHLibrary.Close Connection

Wimp_Logs_check
    [Tags]    SanityTest_Wimp
    Sleep    30s
    SSHLibrary.Open Connection    ${WIMP_HOST}    timeout=1 hour
    SSHLibrary.Login With Public Key    wicqacip    ${RSA_Key}
    : FOR    ${rownum}    IN RANGE    1    ${Countofrecordsinfile}+1
    \    ${R}    Convert To Integer    ${rownum}
    \    ${resultRow}    Read Cell Value By Row    My_TestData1Msgs.csv    ${R}
    \    log    ${resultRow}
    \    ${Phone_Number}    Get From Dictionary    ${resultRow}    patient_phone_number
    \    ${Transaction_Id}    Get From Dictionary    ${resultRow}    transaction_id
    \    ${Patient_Id}    Get From Dictionary    ${resultRow}    patient_id
    \    ${store_phone_number}    Get From Dictionary    ${resultRow}    store_phone_number
    \    Start Command    less ${WIMPLOG}| grep -i ${Phone_Number}
    \    ${std_output}=    Read Command Output
    \    log    ${std_output}
    \    Should Not Contain    ${std_output}    Exception
    \    Should Not Contain    ${std_output}    Warn
    \    Start Command    less ${WIMPLOG}| grep -i ${Phone_Number} | grep -i error
    \    Should Not Contain    ${std_output}    Exception
    \    Should Not Contain    ${std_output}    Warn

Aggregator_Logs_check
    [Tags]    SanityTest_Agg
    SSHLibrary.Open Connection    ${Engine_Server}    timeout=1 hour
    SSHLibrary.Login With Public Key    wicqacip    ${RSA_Key}
    ${Current_Time}    Get Current Date    local
    ${C_Time}    Add Time To Date    ${Current_Time}    -.19 hours
    ${Start_time}    Get Substring    ${C_Time}    11    -7
    ${E_Time}    Add Time To Date    ${Current_Time}    +0.01 hours
    ${End_time}    Get Substring    ${E_Time}    11    -7
    : FOR    ${rownum}    IN RANGE    1    ${Countofrecordsinfile}+1
    \    ${R}    Convert To Integer    ${rownum}
    \    ${resultRow}    Read Cell Value By Row    ${Data_Cleanup_File}    ${R}
    \    log    ${resultRow}
    \    ${Keys}    Get Dictionary Keys    ${resultRow}
    \    ${PhoneNumber_Value}    Get From Dictionary    ${resultRow}    ${Phone_Number}
    \    log    ${PhoneNumber_Value}
    \    Start Command      /usr/local/bin/log_seek ${EngineLog} '^[0-9][0-9]:[0-9][0-9]' '${Start_time}:' '${End_time}:' | grep 'contactAddress=${PhoneNumber_Value}' | awk -F INFO '{print$NF}' | grep "SMS Sent"
    \    ${std_output}=    Read Command Output
    \    Log    ${std_output}
    \    ${mcn_id}       get Substring       ${std_output}      116     163
    \    ${record_id}       get Substring       ${std_output}   223     239    
    \    Log    ${mcn_id} 
    \    Log    ${record_id}
    \    Should Contain     ${std_output}       SMS Sent
    \    Start Command      /usr/local/bin/log_seek ${EngineLog} '^[0-9][0-9]:[0-9][0-9]' '${Start_time}:' '${End_time}:' | grep 'contactAddress=${PhoneNumber_Value}' | awk -F INFO '{print$NF}' | grep "Saving attempt"
    \    ${std_out}=    Read Command Output
    \    Log    ${std_out}
    \    ${mcn_status}       get Substring       ${std_out}      258     285
    \    Run Keyword If    '${mcn_status}'== 'mcnStatus=completed-success'    log      "Pass"      ELSE    log     "Fail"
    \    Log    ${mcn_status}

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

SMS_Message_Content_validation
    [Tags]    VerbiageTest
    ${connection}    Jdbc Connect    ${WIMP_DB_HOST}    ${WIMP_DB_PORT}    ${WIMP_DB_NAME}    ${WIMP_DB_HOST}    ${WIMP_DB_USERNAME}
    ...    ${WIMP_DB_PASSWORD}
    ${date1}    Get Current Date    local
    ${date}    Convert Date    ${date1}    exclude_millis=yes
    ${FutureDate1}    Add Time To Date    ${date1}    .10 hours
    ${FutureDate}    Convert Date    ${FutureDate1}    exclude_millis=yes
    : FOR    ${rownum}    IN RANGE    1    ${Countofrecordsinfile}+1
    \    ${R}    Convert To Integer    ${rownum}
    \    ${resultRow}    Read Cell Value By Row     ${Data_File}    ${R}
    \    log    ${resultRow}
    \    ${PhoneNumber_Value}    Get From Dictionary    ${resultRow}    ${Phone_Number}
    \    log    ${PhoneNumber_Value}
    \    ${Column1}    Get From Dictionary    ${resultRow}    ${transaction_id}
    \    ${VerbiageMessage}    Get From Dictionary    ${resultRow}    ${Verbiage}
    \    ${cursor}    Jdbc Query    ${connection}    set isolation dirty read;
    \    ${cursor}    Jdbc Query    ${connection}    select first 1 message from wicsms:wimp_sent where mobile_number = '001${PhoneNumber_Value}' order by received desc
    \    ${DB_Results}    Jdbc Result    ${cursor}
    \    ${queryResultsNew2}    Convert To String    ${DB_Results}
    \    ${queryResultsNew3}    Get Substring    ${queryResultsNew2}    16    -4
    \    ${a}=    Strip String    ${queryResultsNew3}    mode=right
    \    log    ${a}
    \    Run Keyword If    "'${a}'" == "'${VerbiageMessage}'"    log    Verbiage matched for ${PhoneNumber_Value}
    \    ...    ELSE    log    Verbiage did not match for ${PhoneNumber_Value}
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
    
Checking_2Way-SMS-Verbiage
    [Tags]    SanityTest_2_Way_SMS_2
    : FOR    ${rownum}    IN RANGE    1    ${Countofrecordsinfile}+1
    \    ${R}    Convert To Integer    ${rownum}
    \    ${resultRow}    read_cell_value_by_row    ${Data_File}    ${R}
    \    ${mobile}    Get From Dictionary    ${resultRow}    ${Phone_Number}
    \    ${apn}    Get From Dictionary    ${resultRow}    APN
    \    ${smscode}    Get From Dictionary    ${resultRow}    SHORTCODE
    \    ${Keyword1}    Get From Dictionary    ${resultRow}    Keyword1
    \    ${Keyword2}    Get From Dictionary    ${resultRow}    Keyword2
    \    ${Keyword3}    Get From Dictionary    ${resultRow}    Keyword3
    \    ${Keyword4}    Get From Dictionary    ${resultRow}    Keyword4
    \    ${Keyword5}    Get From Dictionary    ${resultRow}    Keyword5
    \    ${Keyword6}    Get From Dictionary    ${resultRow}    Keyword6
    \    ${Keyword7}    Get From Dictionary    ${resultRow}    Keyword7
    \    ${Keyword8}    Get From Dictionary    ${resultRow}    Keyword8
    \    ${Keyword9}    Get From Dictionary    ${resultRow}    Keyword9
    \    ${Keyword10}    Get From Dictionary    ${resultRow}    Keyword10
    \    ${Keyword11}    Get From Dictionary    ${resultRow}    Keyword11
    \    ${Keyword12}    Get From Dictionary    ${resultRow}    Keyword12
    \    ${Message111}    Get From Dictionary    ${resultRow}    Message1
	\    ${Message1}    Convert To String    ${Message111}
    \    ${Message122}   Get From Dictionary    ${resultRow}    Message2
	\    ${Message2}    Convert To String    ${Message122}
    \    ${Message13}    Get From Dictionary    ${resultRow}    Message3
	\    ${Message3}    Convert To String    ${Message13}
    \    ${Message14}    Get From Dictionary    ${resultRow}    Message4
	\    ${Message4}    Convert To String    ${Message14}
    \    ${Message15}    Get From Dictionary    ${resultRow}    Message5
	\    ${Message5}    Convert To String    ${Message15}
    \    ${Message16}    Get From Dictionary    ${resultRow}    Message6
	\    ${Message6}    Convert To String    ${Message16}
    \    ${Message17}    Get From Dictionary    ${resultRow}    Message7
	\    ${Message7}    Convert To String    ${Message17}
    \    ${Message18}    Get From Dictionary    ${resultRow}    Message8
	\    ${Message8}    Convert To String    ${Message18}
    \    ${Message19}    Get From Dictionary    ${resultRow}    Message9
	\    ${Message9}    Convert To String    ${Message19}
    \    ${Message100}    Get From Dictionary    ${resultRow}    Message10
	\    ${Message10}    Convert To String    ${Message100}
    \    ${Message111}    Get From Dictionary    ${resultRow}    Message11
	\    ${Message11}    Convert To String    ${Message111}
    \    ${Message112}    Get From Dictionary    ${resultRow}    Message12
	\    ${Message12}    Convert To String    ${Message112}
    \    ${a}=    set variable    ${MOHandler_URL}&apn=${apn}&smscode=${smscode}&mobile=${mobile}&message=
    \    log    ${a}${Keyword1}
    \    ${Pass1}    Run Keyword If    '${Keyword1}' != '${EMPTY}'    Get Short Url    ${a}${Keyword1}
    \    ...    ELSE    Continue For Loop
    \    log    ${Pass1}
    \    ${Pass10}=    Fetch From Right    ${Pass1}    REPLY:
    \    ${a1}=    Fetch From Left    ${Pass10}    MT
    \    ${a11}=    Strip String    ${a1}    mode=right
    \    log    ${a11}
    \    Run Keyword If    "'${a11}'" == "'${Message1}'"    log    Verbiage matched for ${Message1}
    \    ...    ELSE    log    Verbiage did not match for ${Message1}
    \    BuiltIn.Sleep    5s
    \    ${Pass2}    Run Keyword If    '${Keyword2}' != '${EMPTY}'    Get Short Url    ${a}${Keyword2}
    \    ...    ELSE    Continue For Loop
    \    log    ${Pass2}
    \    ${Pass20}=    Fetch From Right    ${Pass2}    REPLY:
    \    ${a2}=    Fetch From Left    ${Pass20}    MT
    \    ${a22}=    Strip String    ${a2}    mode=right
    \    log    ${a22}
    \    Run Keyword If    "'${a22}'" == "'${Message2}'"    log    Verbiage matched for ${Message2}
    \    ...    ELSE    log    Verbiage did not match for ${Message2}
    \    BuiltIn.Sleep    5s
    \    ${Pass3}    Run Keyword If    '${Keyword3}' != '${EMPTY}'    Get Short Url    ${a}${Keyword3}
    \    ...    ELSE    Continue For Loop
    \    log    ${Pass3}
    \    ${Pass30}=    Fetch From Right    ${Pass3}    REPLY:
    \    ${a3}=    Fetch From Left    ${Pass30}    MT
    \    ${a33}=    Strip String    ${a3}    mode=right
    \    log    ${a33}
    \    Run Keyword If    "'${a33}'" == "'${Message3}'"    log    Verbiage matched for ${Message3}
    \    ...    ELSE    log    Verbiage did not match for ${Message3}
    \    ${Pass4}    Run Keyword If    '${Keyword4}' != '${EMPTY}'    Get Short Url    ${a}${Keyword4}
    \    ...    ELSE    Continue For Loop
    \    log    ${Pass4}
    \    ${Pass40}=    Fetch From Right    ${Pass4}    REPLY:
    \    ${a4}=    Fetch From Left    ${Pass40}    MT
    \    ${a44}=    Strip String    ${a4}    mode=right
    \    log    ${a44}
    \    Run Keyword If    "'${a44}'" == "'${Message4}'"    log    Verbiage matched for ${Message4}
    \    ...    ELSE    log    Verbiage did not match for ${Message4}
    \    ${Pass5}    Run Keyword If    '${Keyword5}' != '${EMPTY}'    Get Short Url    ${a}${Keyword5}
    \    ...    ELSE    Continue For Loop
    \    log    ${Pass5}
    \    ${Pass50}=    Fetch From Right    ${Pass5}    REPLY:
    \    ${a5}=    Fetch From Left    ${Pass50}    MT
    \    ${a55}=    Strip String    ${a5}    mode=right
    \    log    ${a55}
    \    Run Keyword If    "'${a55}'" == "'${Message5}'"    log    Verbiage matched for ${Message5}
    \    ...    ELSE    log    Verbiage did not match for ${Message5}
    \    ${Pass6}    Run Keyword If    '${Keyword6}' != '${EMPTY}'    Get Short Url    ${a}${Keyword6}
    \    ...    ELSE    Continue For Loop
    \    log    ${Pass6}
    \    ${Pass60}=    Fetch From Right    ${Pass6}    REPLY:
    \    ${a6}=    Fetch From Left    ${Pass60}    MT
    \    ${a66}=    Strip String    ${a6}    mode=right
    \    log    ${a66}
    \    Run Keyword If    "'${a66}'" == "'${Message6}'"    log    Verbiage matched for ${Message6}
    \    ...    ELSE    log    Verbiage did not match for ${Message6}
    \    BuiltIn.Sleep    5s
    \    ${Pass7}    Run Keyword If    '${Keyword7}' != '${EMPTY}'    Get Short Url    ${a}${Keyword7}
    \    ...    ELSE    Continue For Loop
    \    log    ${Pass7}
    \    ${Pass70}=    Fetch From Right    ${Pass7}    REPLY:
    \    ${a7}=    Fetch From Left    ${Pass70}    MT
    \    ${a77}=    Strip String    ${a7}    mode=right
    \    log    ${a77}
    \    Run Keyword If    "'${a77}'" == "'${Message7}'"    log    Verbiage matched for ${Message7}
    \    ...    ELSE    log    Verbiage did not match for ${Message7}
    \    BuiltIn.Sleep    5s
    \    ${Pass8}    Run Keyword If    '${Keyword8}' != '${EMPTY}'    Get Short Url    ${a}${Keyword8}
    \    ...    ELSE    Continue For Loop
    \    log    ${Pass8}
    \    ${Pass80}=    Fetch From Right    ${Pass8}    REPLY:
    \    ${a8}=    Fetch From Left    ${Pass80}    MT
    \    ${a88}=    Strip String    ${a8}    mode=right
    \    log    ${a88}
    \    Run Keyword If    "'${a88}'" == "'${Message8}'"    log    Verbiage matched for ${Message8}
    \    ...    ELSE    log    Verbiage did not match for ${Message8}
    \    ${Pass9}    Run Keyword If    '${Keyword9}' != '${EMPTY}'    Get Short Url    ${a}${Keyword9}
    \    ...    ELSE    Continue For Loop
    \    log    ${Pass9}
    \    ${Pass90}=    Fetch From Right    ${Pass9}    REPLY:
    \    ${a9}=    Fetch From Left    ${Pass90}    MT
    \    ${a99}=    Strip String    ${a9}    mode=right
    \    log    ${a99}
    \    Run Keyword If    "'${a99}'" == "'${Message9}'"    log    Verbiage matched for ${Message9}
    \    ...    ELSE    log    Verbiage did not match for ${Message9}
    \    ${Pass110}    Run Keyword If    '${Keyword10}' != '${EMPTY}'    Get Short Url    ${a}${Keyword10}
    \    ...    ELSE    Continue For Loop
    \    log    ${Pass110}
    \    ${Pass1100}=    Fetch From Right    ${Pass110}    REPLY:
    \    ${a10}=    Fetch From Left    ${Pass1100}    MT
    \    ${a1010}=    Strip String    ${a10}    mode=right
    \    log    ${a1010}
    \    Run Keyword If    "'${a1010}'" == "'${Message10}'"    log    Verbiage matched for ${Message10}
    \    ...    ELSE    log    Verbiage did not match for ${Message10}
    \    ${Pass120}    Run Keyword If    '${Keyword11}' != '${EMPTY}'    Get Short Url    ${a}${Keyword11}
    \    ...    ELSE    Continue For Loop
    \    log    ${Pass120}
    \    ${Pass1200}=    Fetch From Right    ${Pass120}    REPLY:
    \    ${a11}=    Fetch From Left    ${Pass1200}    MT
    \    ${a1111}=    Strip String    ${a11}    mode=right
    \    log    ${a1111}
    \    Run Keyword If    "'${a1111}'" == "'${Message11}'"    log    Verbiage matched for ${Message11}
    \    ...    ELSE    log    Verbiage did not match for ${Message11}
    \    ${Pass130}    Run Keyword If    '${Keyword12}' != '${EMPTY}'    Get Short Url    ${a}${Keyword12}
    \    ...    ELSE    Continue For Loop
    \    log    ${Pass130}
    \    ${Pass1300}=    Fetch From Right    ${Pass130}    REPLY:
    \    ${a13}=    Fetch From Left    ${Pass1300}    MT
    \    ${a1313}=    Strip String    ${a13}    mode=right
    \    log    ${a1313}
    \    Run Keyword If    "'${a1313}'" == "'${Message12}'"    log    Verbiage matched for ${Message12}
    \    ...    ELSE    log    Verbiage did not match for ${Message12}

Test_Data_Cleanup_Final_Enrollment
    [Tags]    PostCondition_Enrollment
    ${connection}    Jdbc Connect    ${DB_Host}    ${DB_Port}    ${DB_Name}    ${DB_Host}    ${DB_Username}
    ...    ${DB_Password}
    ${connection1}    Jdbc Connect    ${WIMP_DB_HOST}    ${WIMP_DB_PORT}    ${WIMP_DB_NAME}    ${WIMP_DB_HOST}    ${WIMP_DB_USERNAME}
    ...    ${WIMP_DB_PASSWORD}
    : FOR    ${rownum}    IN RANGE    1    ${Countofrecordsinfile}+1
    \    ${R}    Convert To Integer    ${rownum}
    \    ${resultRow}    Read Cell Value By Row    ${Data_Cleanup_File}    ${R}
    \    log    ${resultRow}
    \    ${Keys}    Get Dictionary Keys    ${resultRow}
    \    ${PhoneNumber_Value}    Get From Dictionary    ${resultRow}    ${Phone_Number}
    \    log    ${PhoneNumber_Value}
    \    ${ContactPointMethod_Value}    Get From Dictionary    ${resultRow}    ${Contact_Method}
    \    log    ${ContactPointMethod_Value}
    \    ${PatientId_Value}    Get From Dictionary    ${resultRow}    ${PatientId}
    \    log    ${PatientId_Value}
    \    ${NotificationType_Value}    Get From Dictionary    ${resultRow}    ${Notifi_type}
    \    log    ${NotificationType_Value}
    \    ${PreferenceType_Value}    Get From Dictionary    ${resultRow}    ${Pref_type}
    \    log    ${PreferenceType_Value}
    \    ${MessageId_Value}    Get From Dictionary    ${resultRow}    ${MessageId}
    \    log    ${MessageId_Value}
    \    ${cursor}    Jdbc Query    ${connection}    set isolation dirty read;
    \    ${cursor}    Jdbc Query    ${connection}    DELETE FROM ${Enrollment_Format} WHERE ${Enrollment_Format_Column1} = '${PhoneNumber_Value}' AND ${Enrollment_Format_Column2} = '${ContactPointMethod_Value}' AND ${Enrollment_Format_Column3} = '${PreferenceType_Value}'
    \    ${row}=    Set Variable    0.0
    \    ${cursor}    Jdbc Query    ${connection}    SELECT COUNT(*) from ${Enrollment_Format} WHERE ${Enrollment_Format_Column1} = '${PhoneNumber_Value}' AND ${Enrollment_Format_Column2} = '${ContactPointMethod_Value}' AND ${Enrollment_Format_Column3} = '${PreferenceType_Value}'
    \    ${DB_RowCount}    Jdbc Result    ${cursor}
    \    ${rowCount}    Convert To String    ${DB_RowCount}
    \    ${noOfRow}    Get Substring    ${rowCount}    17    -2
    \    Run Keyword If    '${noOfRow}' == '${row}'    log    Cleared data for ${PhoneNumber_Value} from ${Enrollment_Format } table in database
    \    ...    ELSE    log    Failed to clear data for ${RecipientPhoneNumber_Value} from ${Enrollment_Format } table in database
    \    ${cursor1}    Jdbc Query    ${connection}    set isolation dirty read;
    \    ${cursor1}    Jdbc Query    ${connection}    DELETE FROM ${Camp_Format} WHERE ${Camp_Format_Column1} = '${PhoneNumber_Value}' AND ${Camp_Format_Column2} = '${NotificationType_Value}' AND ${Camp_Format_Column3} = '${MessageId_Value}'
    \    ${row1}=    Set Variable    0.0
    \    ${cursor1}    Jdbc Query    ${connection}    SELECT COUNT(*) from ${Camp_Format} WHERE ${Camp_Format_Column1} = '${PhoneNumber_Value}' AND ${Camp_Format_Column2} = '${NotificationType_Value}' AND ${Camp_Format_Column3} = '${MessageId_Value}'
    \    ${DB_RowCount1}    Jdbc Result    ${cursor1}
    \    ${rowCount1}    Convert To String    ${DB_RowCount1}
    \    ${noOfRow1}    Get Substring    ${rowCount1}    17    -2
    \    Run Keyword If    '${noOfRow1}' == '${row1}'    log    Cleared data for ${PhoneNumber_Value} from ${Camp_Format} table in database
    \    ...    ELSE    log    Failed to clear data for ${PhoneNumber_Value} from ${Camp_Format} table in database
    \    ${cursor2}    Jdbc Query    ${connection1}    set isolation dirty read
    \    ${cursor2}    Jdbc Query    ${connection1}    DELETE FROM ${Wimp_Table} WHERE ${Wimp_Table_Column1} = '001${PhoneNumber_Value}'
    \    ${row2}=    Set Variable    0.0
    \    ${cursor2}    Jdbc Query    ${connection1}    SELECT COUNT(*) FROM ${Wimp_Table} WHERE ${Wimp_Table_Column1} = '001${PhoneNumber_Value}'
    \    ${DB_RowCount2}    Jdbc Result    ${cursor2}
    \    ${rowCount2}    Convert To String    ${DB_RowCount2}
    \    ${noOfRow2}    Get Substring    ${rowCount2}    17    -2
    \    Run Keyword If    '${noOfRow2}' == '${row2}'    log    Cleared data for ${PhoneNumber_Value} from ${Wimp_Table} table in database
    \    ...    ELSE    log    Failed to clear data for ${PhoneNumber_Value} from ${Wimp_Table} table in database
    Jdbc Release    ${cursor}
    Jdbc Release    ${cursor1}
    Jdbc Release    ${cursor2}
    Jdbc Disconnect    ${connection}
    Jdbc Disconnect    ${connection1}

Test_Data_Cleanup_Final_Camp_Format
    [Tags]    PostCondition_Format_Cleanup
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
