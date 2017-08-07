Library-Extraction
==============================

Library-Extraction is a utility written in Ruby that inserts account information from the Toronto Public Library into an Emacs Org Mode agenda, a software day planner. It scans the TPL site and gathers the due dates of borrowed books, as well as the names and  deadlines of items on hold that are ready to pick up.  This information is written to a generated .org then used as input by Org Mode Agenda.

#### CONFIGURATION
In the config/config.yml file, set your TPL website username and password as variables `tpl_username` and `tpl_password `. In addition, use the variable `org_agenda_file` to set the full path of the generated .org  file. Lastly, inform Emacs of the existence and location of this file by adding it to the Emacs list `org-agenda-files`.


#### REQUIREMENTS
Ruby, rake, and the installed gems nokogiri, mechanize, and yaml.

#### USAGE
Run `rake'.

#### TODO
* Needs error reporting when there is misconfiguration of username and password.



----------------
