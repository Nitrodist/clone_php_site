# Clone php site

You can use these set of scripts to sort of clone a passworded php site easily

## monitor

You can use `monitor` to detect the 'login' prompt that exists on pages when your session expires (i.e, you get logged out after 30 minutes and you're grabbing incomplete pages now).

## remove\_index\_files

You can use `remove_index_files` to remove all of the index files that you notice in the program so that you can resume cloning the site in the case you're interrupted.

## remove\_question\_marks

All of the pages cloned with wget would keep the question marks in their name like `index.php?id=3` which would make it impossible to navigate next to locally with a browser (since it interprets it as a query parameter and not the name of the file). 

This uses nokogiri to remove the question marks from the links in the files and then to move the files to their proper location.

## wget\_script

This is the command I used with wget clone to:

1. Clone the site
2. Resume and not clobber over old files that I had already downloaded
