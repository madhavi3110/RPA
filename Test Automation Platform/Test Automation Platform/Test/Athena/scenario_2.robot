*** Settings ***
Documentation     Instrument Engineering Interface (WICS) Start Up.
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
2.2 Verify the version of Linux running on the AICS.
    ${output}=    Execute Command    hostnamectl
    Should Contain    ${output}    Ubuntu 18.04     
