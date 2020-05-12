# $moduleRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
# Import-Module "$moduleRoot\src\Use-HelloWorld.psm1" -Force

Describe 'Helloworld' {

#Testing folder
        it "Has a C:\Program Files\MySQL" {
            Test-Path "C:\Program Files\MySQL" |
                Should Be True
        }
		
#Testing files		
		it "Has a C:\Program Files\MySQL" {
            Test-Path "C:\Program Files\MySQL" |
                Should Be True
        }

#Testing path
        it "Has a https://dev.azure.com/44976/44976/" {
            Test-Path "https://dev.azure.com/44976/44976/" |
                Should Be True
        }
		
#Testing server installed
        it "Has SQL Server installed" {
            Get-Service MySQL* |
                Should Not BeNullOrEmpty
        }
		
#Testing server running
        it "Has SQL Server running" {
            (Get-Service MySQL*).Status |
                Should Be "Running"
        }


        it "Has correct SA password" -Pending {
            {throw "Not yet implemented"} |
                Should -Not -Throw
        }

#Testing sql version 
        it "Running SQL Server 2012 11.0.5058" {
       
            $results = Invoke-sqlcmd MySQL*  "Select @@Version"
            $results.Column1 |
                Should Match "11.0.5058"
        }

#Testing sql cmd
        It "@@ServerName matches hostname" {
            $name = Invoke-SQLCMD "SELECT @@Servername as Name" | % name
            $name | Should -Be $env:DESKTOP-D46023H
        }
		
		
#Testing webRequest
        It -Name 'http://server01/login.aspx is available' {

            $Svr1web = Invoke-WebRequest -Uri 'http://server01/login.aspx'
            $Svr1web.StatusCode | Should BeExactly '200'

        }
				
    
}