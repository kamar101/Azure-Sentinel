$key = "access_key=4cbbed61a1d2aa72a98da7097f8178a9"
$API_URl = "http://api.ipapi.com/"
$LOGFILE_PATH = "C:\Users\mrhacker\Documents\logs.txt"

$events = Get-EventLog -LogName Security | Where-Object {$_.EventID -eq 4625}

foreach($log in $events){

    $timestap = $log.TimeWritten
    $user_name = $log.ReplacementStrings[5]
    $computer_name = $log.ReplacementStrings[1]
    $event_ip = $log.ReplacementStrings[19]

    if ((Test-Path $LOGFILE_PATH) -eq $false) {
        
        #Create Log file with sample logs
        New-Item -ItemType File -Path $LOGFILE_PATH
        "latitude:47.91542,longitude:-120.60306,destinationhost:samplehost,username:fakeuser,sourcehost:24.16.97.222,state:Washington,country:United States,label:United States - 24.16.97.222,timestamp:2021-10-26 03:28:29" | Out-File $LOGFILE_PATH -Append -Encoding utf8
        "latitude:-22.90906,longitude:-47.06455,destinationhost:samplehost,username:lnwbaq,sourcehost:20.195.228.49,state:Sao Paulo,country:Brazil,label:Brazil - 20.195.228.49,timestamp:2021-10-26 05:46:20" | Out-File $LOGFILE_PATH -Append -Encoding utf8
        "latitude:52.37022,longitude:4.89517,destinationhost:samplehost,username:CSNYDER,sourcehost:89.248.165.74,state:North Holland,country:Netherlands,label:Netherlands - 89.248.165.74,timestamp:2021-10-26 06:12:56" | Out-File $LOGFILE_PATH -Append -Encoding utf8
        "latitude:40.71455,longitude:-74.00714,destinationhost:samplehost,username:ADMINISTRATOR,sourcehost:72.45.247.218,state:New York,country:United States,label:United States - 72.45.247.218,timestamp:2021-10-26 10:44:07" | Out-File $LOGFILE_PATH -Append -Encoding utf8
        "latitude:33.99762,longitude:-6.84737,destinationhost:samplehost,username:AZUREUSER,sourcehost:102.50.242.216,state:Rabat-Salé-Kénitra,country:Morocco,label:Morocco - 102.50.242.216,timestamp:2021-10-26 11:03:13" | Out-File $LOGFILE_PATH -Append -Encoding utf8
  
     }

    #Used to prevent duplicates
    $file = Get-Content $LOGFILE_PATH
    $containsWord = $file | %{$_ -match "timestamp:$timestap"}

    if($containsWord -contains $false){

        #Sending API request
        $complete_URL = $API_URl + $event_ip + "?"+$key
        $request_response = Invoke-RestMethod $complete_URL

        # Error Handling for failed API request
        if($request_response.success -eq $False){
            echo $request_response
            break
        }

        #Phrasing API output
        $ip = $request_response.ip
        $type =$request_response.type          
        $country_code   = $request_response.country_code
        $country_name   =$request_response.country_name
        $state_code = $request_response.region_code
        $region_name = $request_response.region_name
        $city = $request_response.city   
        $latitude = $request_response.latitude
        $longitude =$request_response.longitude

        #Formating logs for entry
        $entry = "latitude:$latitude,longitude:$longitude,username:$user_name,sourcehost:$event_ip,city:$city,country:$country_name,label:$country_name - $ip,timestamp:$timestap"

        #Writing logs to file
        echo "writting:  $entry "
        $entry |Out-File $LOGFILE_PATH -Append -Encoding utf8 

}}
