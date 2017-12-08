# Setting Up An Active Directory Test Lab in Microsoft Azure

This is only been tested on a Windows 10 Machine

 **##LEGAL DISCLAIMER This Sample Code is provided for the purpose of illustration only and is not intended to be used in a production environment. THIS SAMPLE CODE AND ANY RELATED INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE. We grant You a nonexclusive, royalty-free right to use and modify the Sample Code and to reproduce and distribute the object code form of the Sample Code, provided that You agree: (i) to not use Our name, logo, or trademarks to market Your software product in which the Sample Code is embedded; (ii) to include a valid copyright notice on Your software product in which the Sample Code is embedded; and (iii) to indemnify, hold harmless, and defend Us and Our suppliers from and against any claims or lawsuits, including attorneys’ fees, that arise or result from the use or distribution of the Sample Code.** 

This posting is provided "AS IS" with no warranties, and confers no rights. Use of included script samples are subject to the terms specified at http://www.microsoft.com/info/cpyright.htm.

## TL;DR

Setup a Domain Control in Microsoft Azure for learning powershell

1. download the calling script 
2. Read the script and make modifications
3. Run The script and the commands to deploy test environment
4. Practice 
5. Run Final Command to delete the test environment

# **The Azure PowerShell Test Lab**

The Azure PowerShell Test Lab is based on a fork of [Ashley McGlone's](https://github.com/GoateePFE) [AzureRM](https://github.com/GoateePFE/AzureRM). Forked as a baseline for creating a easily deployable and colapsable PowerShell Learning and Testing enivironment in Microsoft Azure it is a modification of the GitHub AzureRM repo template for a single DC deployment. This version uses DSC with a configuration data file to deploy the domain and populate sample data for an instant AD test lab.

The Test lab can be deployed to azure in 30 minutes with 4 commands and completely torn down and deleted in 15 minutes

after the final deployment command is run you can log off and walk away. when you come back in 30 minutes you will have a fully functioning Windows Server rolled as a Domain Controler and populated with Active Directory Users that you can run PowerShell Commands Against.

When you are done you can run 1 command to tear down everything.

## **What does this have to do with learning PowerShell?**

The best way to learn to learn PowerShell is to use PowerShell in an environment as close to production as possible.

In order to run PowerShell commands in a real environment we need a real environment, preferably an environment where we can afford to make mistakes.

By following the instructions here, studying the scripts and learning how they work, and by deploying and deconstructing the test environment, you will learn how to use PowerShell. You will more than likely learn a hand full of other technologies like azure, remote desktop, git, and github to say the least.

when you are more familier with powershell and scripting or, if your all about this life, [download everything](https://github.com/TheRealCasadaro/AzurePowerShellTestLab) , Tweak the DSC configuration, DSC configuration data, and azuredeploy.json Like a Boss. Then host them on your own GitHub or Azure storage account.

# **Warning**

Make sure you don't include any sensative info in your modifications, don't try to be funny and use the names of real organizations and people, and ALWAY tear down your environment if you are not going to be using it!

Azure charges for everything and while to cost is low if we are engaged in focused learning for a few houres a day and or running a money making enterprise, the cost can add up if we just leave or lab idling in Azure.

## ** Lets Get Started?**

If you don't have them already, you are going to to download and install the following 

- [PowerShell (any machine) ](https://docs.microsoft.com/en-us/powershell/scripting/setup/installing-windows-powershell?view=powershell-5.1)
- [Windows Management Framework (if your on a windows machine)](https://www.microsoft.com/en-us/download/details.aspx?id=54616)
- [Visual Studio Code (on any machine)](https://code.visualstudio.com/)

## Download `CallingScript.ps1` to your local machine.

This is all about learning right?

Here are a couple of scripts. Read Them, Learn Them, if you save them to a text file with an extension of `ps1` they will download the `CallingScript.ps1` to the directory you are in when you run either of them. 

    #sets variable for the location of what we want to download
    $url = "https://raw.githubusercontent.com/TheRealCasadaro/AzureRM/master/active-directory-new-domain-with-data/CallingScript.ps1"
    
    #sets variable for the download location, in this case the its the directy of whe we execute the script from
    $output = "$PSScriptRoot\CallingScript.ps1"
    
    #sets variable for the current time from our local machine
    $start_time = Get-Date
    
    #assignes the web client to a variable so we can use it later
    $wc = New-Object System.Net.WebClient
    
    #invokes the downloadfile methode of the webclient object we assined to the variable $wc. The methode is a function that takes two arguments. These are the varible we assined earlier. 
    $wc.DownloadFile($url, $output)
    
    #shows you how long the download took
    Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

Here is another way we can write our downloader script

    #sets vaiable for the location of what we want to download
    $url = "https://raw.githubusercontent.com/TheRealCasadaro/AzureRM/master/active-directory-new-domain-with-data/CallingScript.ps1"
    
    #sets variable for the download location, in this case the its the directy of whe we execute the script from
    $output = "$PSScriptRoot\CallingScript.ps1"
    
    #sets variable for the current time from our local machine
    $start_time = Get-Date
    
    #creates a webclient object then invokes the Downlide file method and feeds it the input and output we defined earlier
    (New-Object System.Net.WebClient).DownloadFile($url, $output)
    
    #shows you how long the download took
    Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

Here is a zip file of the scripts for your convenience ( [click here](https://github.com/TheRealCasadaro/AzurePowerShellTestLab/blob/master/callScriptDownloader.zip) )

As you go through these steps you might see allot of room for improvement. For instance, when I first learned how to do this I didn't know about Docker or Azure containers. 

It was going through this process, the process taught me about the things I didn't know. For instance, this entire process can be completed with one command and a few questions to the person running it. 

In order to make that possible we have to know how all this stuff works. 

## Errors and Elevations

Errors are going to be shown in blocks of red text, read these errors.

1.  `errors` tell you what went wrong
2.  `errors` help us learn
3. fixing `errors` will become second nature. Its like being able to see into the [Matrix](https://en.wikipedia.org/wiki/The_Matrix) 

To run some of these command we are going to have to do them in am elevated PowerShell session. 

There are a couple of ways to do this. 

- We can right click on our PowerShell icon and select run as Administrator

Or we can run `Start-Process powershell -Verb runAs` . 

 `-Verb` <String>
Specifies a verb to use when this cmdlet starts the process. The verbs that are available are determined by
the file name extension of the file that runs in the process.

 `runAs` 

## Running the calling script

At some point I will automate this process (maybe)

1. Read through the calling script and make changes where noted
2. copy the script to your system clip board
3. right click inside you elevated PowerShell window

  This will cause the script to run line by line

4. When for you Azure Credentials enter your Azure username and password
5. you will be asked for a password for the Administrator of your test environment 

When the script is done running you will see the message

    #Setup Complete
    #Connect to your Domain Controler using either the FQDN or Ip

To open a remote session to your Domain Controller use one of the following commands

    #Connect using the fully Qualified Domain Name(FQDN)
    Start-Process -FilePath mstsc.exe -ArgumentList "/v:$FQDN"

    #Connect using your domains public IP Address
    Start-Process -FilePath mstsc.exe -ArgumentList "/v:$IP"

we now have a fully funtions server in Azure that contains 

- Recycle bin enabled
- Admin tools installed
- Five new Organization Unit (OU) structures
- Users and populated groups within the OU structures
- Users root container has test users and populated test groups

were we can try anything we want with and without powershell

Now we can login, learn stuff, break stuff and buld stuff.

Our login information will be the domain name we set in our script followed by a back slash adadministrator

    # Login as: <your Domain name>\adadministrator
    # Use the password you supplied at the beginning of the build.

When we are done in our environment, we can either logoff, close the remote desktop window or just go to our main desktop. 

Either we way chose, we have to decommision or testing environment, unless we want to pay the price for leaving it running. 

To tear down our environment we run the command 

     Remove-AzureRmResourceGroup -Name $rgname -Force -Verbose
