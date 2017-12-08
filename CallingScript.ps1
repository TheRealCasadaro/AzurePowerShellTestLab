#Installs the azure resource manager from PowerShell Gallery
    # Takes a while to install 28 modules
    #The `-force` switch tells PowerShell to overwrite anything that already exist -verbose tells powershell to tell you everything it is doing
    Install-Module AzureRM -Force -Verbose
    #so we can
    Install-AzureRM
    
    # Install the Azure Service Management module from PowerShell Gallery
    Install-Module Azure -Force -Verbose
    
    # Import AzureRM modules for the given version manifest in the AzureRM module
    Import-AzureRM -Verbose
    
    # Import Azure Service Management module
    Import-Module Azure -Verbose
    
    #Authenticate to your Azure account
    Login-AzureRmAccount
    
    # everything with a $ in front of it is a variable. Each variable has to be loaded into memory so they can be called later 
    # loads our environment configurationfile into memerory 
    $URI = 'https://raw.githubusercontent.com/TheRealCasadaro/AzurePowerShellTestLab/master/active-directory-new-domain-with-data/azuredeploy.json'
    
    # chose the region closest to you or your favorite
    # complete list of regions [https://azure.microsoft.com/en-us/regions/](https://azure.microsoft.com/en-us/regions/) 
    # Adjust the 'yournamehere' part of these three strings to
    # something unique for you. Must be lowercase with no spaces or special characters. Leave the last two characters in each.
    $Location = 'east us' 
    $rgname = 'yournamehererg'
    $saname = 'yournameheresa' # Lowercase required
    $addnsName = 'yournameheread' # Lowercase required
    
    # Check that the public dns $addnsName is available
    if (Test-AzureRmDnsAvailability -DomainNameLabel $addnsName -Location $Location)
    { 'Available' } else { 'Taken. addnsName must be globally unique.' }
    
    # Create the new resource group. Runs quickly.
    New-AzureRmResourceGroup -Name $rgname -Location $Location
    
    # Parameters for the template and configuration
    $MyParams = @{
     newStorageAccountName = $saname
     location = 'East US'
     domainName = 'alpineskihouse.com'
     addnsName = $addnsName
     }
    
    #learn splatting, very cool very usefule. 
    # Splat the parameters on New-AzureRmResourceGroupDeployment 
    $SplatParams = @{
     TemplateUri = $URI 
     ResourceGroupName = $rgname 
     TemplateParameterObject = $MyParams
     Name = 'AlpineSkiHouseForest'
     }
    
    # This takes ~30 minutes
    # One prompt for the domain admin password
    New-AzureRmResourceGroupDeployment @SplatParams -Verbose
    
    # Find the VM IP and FQDN
    $PublicAddress = (Get-AzureRmPublicIpAddress -ResourceGroupName $rgname)[0]
    $IP = $PublicAddress.IpAddress
    $FQDN = $PublicAddress.DnsSettings.Fqdn
    
    #Setup Complete
    #Connect to your Domain Controler using either the FQDN or Ip


    # #-------------------------------------------------------------------------
    # # Connect to your Domain Controler using either the FQDN or Ip
    # Start-Process -FilePath mstsc.exe -ArgumentList "/v:$FQDN"
    
    # Start-Process -FilePath mstsc.exe -ArgumentList "/v:$IP"
    
    
    # # Login as: alpineskihouse\adadministrator
    
    # # Use the password you supplied at the beginning of the build.
    
    
    
    # # Explore the Active Directory domain:
    
    # # Recycle bin enabled
    
    # # Admin tools installed
    
    # # Five new OU structures
    
    # # Users and populated groups within the OU structures
    
    # # Users root container has test users and populated test groups
    
    # # Delete the entire resource group when finished
    # Remove-AzureRmResourceGroup -Name $rgname -Force -Verbose