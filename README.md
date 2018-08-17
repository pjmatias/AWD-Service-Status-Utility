AWD Service Status Utility
Version 1.1 - August 17, 2018

----------------
Contents
----------------
1 - Overview
2 - Change history
3 - Requirements
4 - Installation and configuration
5 - Known issues
6 - Instructions for use
7 - License

----------------
Overview
----------------

The AWD Service Status Utility is a ruby-based, command-line program for accessing AWD's published APIs for retrieving batch job status.  It generates an XML file listing every batch job configured in an AWD environment, with the current status and schedule for each job.

----------------
Change history
----------------

v1.1 - Added functionality to the AwdCall class to take a paramaterized URL, allowing duplicate code to be removed from the main file and creating a more flexible, OOP-based model.  Stopped requiring 'P' at the DPC input to trigger the prod environment.  The non/prod variables will now be evaluated based on the environment input.  Added error handling in the event a non-200 HTTP code is returned by the server.

----------------
Requirements
----------------

This utility requires Ruby.  It was built and tested on version 2.5.1.  The installation site must also have access to the targeted AWD environments.

The following Ruby gems are required:
- net/http
- nokogiri
- csv
- logger
- io/console

----------------
Installation and configuration
----------------

All files should be extracted to a single directory.

To configure:
	1 - Open the env_config.rb in a text editor.
	2 - Modify the $server, $server_dpc_non and $server_dpc_prod values to match the location of your AWD installation.  The $server value should be used if you have a consistent server location for both prod and non-prod environments.  The $server_dpc_non and $server_dpc_prod should be used if you have different locations for prod and non-prod.
	3 - Save the file
	4 - If specific certificates are required to access your AWD installation, replace the cacert.pem file with a pem file containing those specific certificates.
	
	
----------------
Known issues
----------------

None

----------------
Instructions for use
----------------

Launch the AWD Service Status.rb file.  At the prompt, enter the desired environment.  The DPC prompt allows you to switch between the endpoints configured in the env_config.rb file.  'N' triggers the $server value, 'Y' triggers the $server_dpc_prod value if the environment you entered is prod and $server_dpc_non if you entered a non-prod environment.  Enter valid credentials for the environment.  The user must have permission to the AWD Design Studio.

The utility will then access the environment and save the batch job status in the file sysstatus.xml.  Open the XML file to view the information.

----------------
License
----------------
This project is licensed under the MIT License - see LICENSE for details.
