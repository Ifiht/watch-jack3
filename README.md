# ![](https://github.com/Ifiht/watch-jack/blob/master/images/icon.png "/&,") ***Jack***

Anyone who's ever delved into the oubliette of Mac's hidden files has seen how much chaff accumulates overtime. Jack records the initial state of your filesystem after a clean install, then identifies any changes made afterwards by adding a label to the file.

Usage:

* beanstalk -b, --baseline  ; stores the current filesystem for later comparison
* beanstalk -u, --update    ; adds a red label to any file not present at the baseline run
* beanstalk -r, --remove    ; removes all labels
