## Description

 A bunch of not really scripts that can be useful

 ## awsconsolelogin.py

Basically a flask web server ( listens on localhost:5000 ) that displays a web page with one line per entry in your ~/.aws/credentials file. When clicking on the link it will do a federation login and log you into the AWS console.
- Usage: just run it as your user with no arg.
- Bonus: add a subfolder called img with a "jpg" file named "profile".jpg for each of your profiles and you  will have a nicer display
