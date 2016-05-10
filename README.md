Library-Extraction
==============================

Library-Extraction is a utility written in Ruby to insert account information from the Toronto Public Library into one's Emacs Org Mode agenda, a software day planner. It scans the TPL site and gathers the due dates of borrowed books, as well as the names and  deadlines of items on hold that are ready to pick up.  This information is then written to an output file designed to be incorporated into Emacs.

#### CONFIGURATION
Setting the TPL website username and password into the config/config.yml file as variables tpl_username and tpl_password.  In Emacs you will need to include the full path of the output file in your org-agenda-files list. The output file name may be modified if one prefers something other than ~/Documents/tpl.org by changing the  variable org_agenda_file.

#### REQUIREMENTS
Ruby, rake, and the installed gems nokogiri, and yaml.

#### USAGE
Run `rake'.

#### TODO
* Needs error reporting when there is misconfiguration of username and password.



----------------
