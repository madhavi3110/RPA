*** Settings ***
Documentation     AICS Instrument Hardware and Software System Functionality.
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

1 FPGA Enumeration & JTAG Communication Test 
        SSHLibrary.Write	sudo fpc reg_read 0x00
	${output}=	SSHLibrary.Read Until	:
	Should Contain    ${output}	[sudo] password for developer:
	SSHLibrary.Write	${PASSWORD}
	${output}=	SSHLibrary.Write	\n\n
	Should Contain	  ${output}	0x0e141c0b

3 To verify that AICS PCIe Driver is Installed
    	${output}=    Execute Command  ls /usr/lib/modules/$(uname -r)/aics
    	Should Contain    ${output}    aics-core.ko  aics-cvp.ko

4 Verify that AICS PCIe Driver is Insterted
    	${output}=    Execute Command  lsmod |grep aics
    	Should Contain    ${output}    aics_core

6 V4L2 Devices test : To check whether the 4 video devices were present
	${output}= 	Execute Command 	ls /dev/video*
	Should Contain 	${output} 	 /dev/video0\n/dev/video1\n/dev/video2\n/dev/video3

12 Set LPE to master for frame number control	
	${output}= 	Execute Command 	aicsctl set-lpe-master 1 && aicsctl get-lpe-master
	Should Be Equal As Strings 	${output} 	setting lpe master state\nlpe is master

13 Set LPE to slave for frame number control
	${output}=    Execute Command  aicsctl set-lpe-master 0 && aicsctl get-lpe-master
	Should Be Equal As Strings    ${output}		setting lpe master state\nlpe is slave

14 Set Binning Mode
	${output}=    Execute Command  aicsctl set-binning 1 && aicsctl get-binning
	Should Be Equal As Strings    ${output}		setting binning state\nbad value\nbinning mode is enabled

15 Disable Binning Mode
	${output}=    Execute Command  aicsctl set-binning 0 && aicsctl get-binning
	Should Be Equal As Strings	 ${output}   setting binning state\nbad value\nbinning mode is disabled


	