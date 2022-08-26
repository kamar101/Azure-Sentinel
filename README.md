<h1>Azure Sentinel: Failed RDP Login Event Mapped by Geolocation</h1>

<h2>Description</h2>
<b>The project consists of a Powershell script which is used to parse out Windows Event Log information for failed RDP logins and use a third-party API(ipapi) to collect geographic information about the login location.
</b>
<br />

<h2>Languages Used</h2>

- <b>PowerShell:</b> 

<h2>Utilities Used</h2>

- <b>api.ipapi.com</b> IP Address to Geolocation API

<h2>Runnning the script to generate the custom logs that would be used by Azure Sentinel</h2>

<p align="center">
<img src="https://imgur.com/jd4ppOy.png" height="85%" width="85%" alt="Image Analysis Dataflow"/>
</p>

<h2>Deploying Azure Sentinel with the custom log file</h2>

<p align="center">
<img src="https://imgur.com/US8vhWE.png" height="85%" width="85%" alt="Image Analysis Dataflow"/>
</p>

<h2>Extracting data from custom logs to be used as custom fields </h2>

<p align="center">
<img src="https://imgur.com/YfBq96Y.png" height="85%" width="85%" alt="Image Analysis Dataflow"/>
</p>

<h2>Verifying custom fields are parsing properly</h2>

<p align="center">
<img src="https://imgur.com/VBRwfYq.png" height="85%" width="85%" alt="Image Analysis Dataflow"/>
</p>

<h2>Using KQL to deploy azure sentinel workbook and configure Map</h2>

<p align="center">
<img src="https://imgur.com/Jalxlmo.png" height="85%" width="85%" alt="Image Analysis Dataflow"/>
</p>

<h2>World map of incoming attacks after 24 hours</h2>

<p align="center">
<img src="https://imgur.com/1ygox4D.png" height="85%" width="85%" alt="Image Analysis Dataflow"/>
</p>


<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>
