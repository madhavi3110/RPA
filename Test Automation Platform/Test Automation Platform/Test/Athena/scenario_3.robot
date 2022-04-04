*** Settings ***
Documentation     AICS instrument hardware and software system functionality.
...

Library	               Screenshot 
Library                SSHLibrary
Library 	       String
Library                Collections
Library                BuiltIn

Suite Setup            Open Connection And Log in AICS
Suite Teardown         Close All Connections

Force Tags
Default Tags


*** Keywords ***
Open Connection And Log In AICS
   Open Connection    ${HOST}
   Login    ${USER}    ${PASSWORD}
   
*** Test Cases ***
    
3.1 Verify the video feed channels via FPGA enumeration.  
    ${output}=    Execute Command  ls /dev/video*
    Should Contain    ${output}     /dev/video0 /dev/video1 /dev/video2 /dev/video3

    
