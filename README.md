

##LEGAL DISCLAIMER This Sample Code is provided for the purpose of illustration only and is not intended to be used in a production environment. THIS SAMPLE CODE AND ANY RELATED INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE. We grant You a nonexclusive, royalty-free right to use and modify the Sample Code and to reproduce and distribute the object code form of the Sample Code, provided that You agree: (i) to not use Our name, logo, or trademarks to market Your software product in which the Sample Code is embedded; (ii) to include a valid copyright notice on Your software product in which the Sample Code is embedded; and (iii) to indemnify, hold harmless, and defend Us and Our suppliers from and against any claims or lawsuits, including attorneys’ fees, that arise or result from the use or distribution of the Sample Code.
This posting is provided "AS IS" with no warranties, and confers no rights. Use of included script samples are subject to the terms specified at http://www.microsoft.com/info/cpyright.htm.


#The Azure PowerShell Test Lab

The Azure PowerShell Test Lab is based on a fork of [Ashley McGlone's](https://github.com/GoateePFE) [AzureRM](https://github.com/GoateePFE/AzureRM). Forked as a baseline for creating a easily deployable and colapsable PowerShell Learning and Testing enivironment in Microsoft Azure it is a modification of the GitHub AzureRM repo template for a single DC deployment. This version uses DSC with a configuration data file to deploy the domain and populate sample data for an instant AD test lab.

The Test lab can be deployed to azure in 30 minutes with 4 commands and completely torn down and deleted in 15 minutes

after the final deployment command is run you can log off and walk away. when you come back in 30 minutes you will have a fully functioning Windows Server rolled as a Domain Controler and populated with Active Directory Users that you can run PowerShell Commands Against.

When you are done you can run 1 command to tear down everything. 

## What does this have to do with learning PowerShell?

The best way to learn to learn PowerShell is to use PowerShell in an environment as close to production as possible. 

In order to run PowerShell commands in a real environment we need a real environment, preferably an environment where we can afford to make mistakes. 

By following the instructions here, studying the scripts and learning how they work, and by deploying and deconstructing the test environment, you will learn how to use PowerShell.  You will more than likely learn a hand full of other technologies like azure, remote desktop, git, and github to say the least. 

when you are more familier with powershell and scripting or, if your all about this life, download everything, Tweak the DSC configuration, DSC configuration data, and azuredeploy.json Like a Boss. Then host them on your own GitHub or Azure storage account.

## Warning
Make sure you don't include any sensative info in your modifications, don't try to be funny and use the names of real organizations and people, and ALWAY tear down your environment if you are not going to be using it!  

Azure charges for everything and while to cost is low if we are engaged in focused learning for a few houres a day and or running a money making enterprise, the cost can add up if we just leave or lab idling in Azure. 

## Lets Get Started? 
1. Download CallingScript.ps1 to your local machine.
2. 