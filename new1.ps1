Describe "SQL Configuration" {
   
    Context "General Config" {

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
        it "Has a C:\Program Files\MySQL\MySQL Workbench 8.0 CE\data" {
            Test-Path "C:\Program Files\MySQL\MySQL Workbench 8.0 CE\data" |
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
	
	

    }
#Testing services are running

    $Services = @(
        'DHCP Client', 'DNS Client','Network Connections', 'Plug and Play', 'RpcSs', 'lanmanserver',
        'LmHosts', 'Lanmanworkstation', 'MySQL80', 'WinRM'
    )

 
describe 'ACME Services' {
    context 'Service Availability' {
        $Services | ForEach-Object {
            it "[$_] should be running" {
                (Get-Service $_).Status | Should Be running
            }
        }
    }
}

#testing ports are up and running
describe 'ACME Ports' {
    context 'Listening ports' {
        135, 3306, 445 | Foreach-Object {
            it "Port [$_] is listening" {
                $portListening = (Test-NetConnection -Port $_ -ComputerName DESKTOP-D46023H).TcpTestSucceeded
                $portListening | Should Be $true
            }
        }
    }
}



#testing dns server services

$nameservers = "8.8.8.8","208.67.222.222"

Describe 'DNS External GSLB ZONE Checks' {
    foreach ($nameserver in $nameservers)
    {
        Context "Checking $nameserver for A records" {
            It "<name> should return <expected>" -TestCases @(
            @{Name = 'discussions.citrix.com'; Expected = '23.29.105.237'}
            @{Name = 'citrix.com'; Expected = '162.221.156.156'}
            @{Name = 'www.google.com'; Expected = ' 216.58.196.164'}
            ) {
            param ($name, $Expected)
        
            $record = Resolve-DnsName $name -type DESKTOP-D46023H -server $nameservers
            $record.IPAddress | Should Be $Expected
            }

        }
    }
    }
