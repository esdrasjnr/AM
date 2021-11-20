#!/bin/sh

URL="https://raw.githubusercontent.com/ivan-hc/APP-Manager/main"
arch=$(uname -m)
currentuser=$(who | awk '{print $1}')

cd /opt/app
case "$1" in
  ''|'-h'|'help') echo '
 ------------------------------------------------------------------------
                                                                           
                AAA               PPPPPPPPPPPPPPPPP   PPPPPPPPPPPPPPPPP   
               A:::A              P::::::::::::::::P  P::::::::::::::::P  
              A:::::A             P::::::PPPPPP:::::P P::::::PPPPPP:::::P 
             A:::::::A            PP:::::P     P:::::PPP:::::P     P:::::P
            A:::::::::A             P::::P     P:::::P  P::::P     P:::::P
           A:::::A:::::A            P::::P     P:::::P  P::::P     P:::::P
          A:::::A A:::::A           P::::PPPPPP:::::P   P::::PPPPPP:::::P 
         A:::::A   A:::::A          P:::::::::::::PP    P:::::::::::::PP  
        A:::::A     A:::::A         P::::PPPPPPPPP      P::::PPPPPPPPP    
       A:::::AAAAAAAAA:::::A        P::::P              P::::P            
      A:::::::::::::::::::::A       P::::P              P::::P            
     A:::::AAAAAAAAAAAAA:::::A      P::::P              P::::P            
    A:::::A             A:::::A   PP::::::PP          PP::::::PP          
   A:::::A               A:::::A  P::::::::P          P::::::::P          
  A:::::A                 A:::::A P::::::::P          P::::::::P          
 AAAAAAA                   AAAAAAAPPPPPPPPPP          PPPPPPPPPP          

 ▄▀█ █▀█ █▀█ █░░ █ █▀▀ ▄▀█ ▀█▀ █ █▀█ █▄░█   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀█
 █▀█ █▀▀ █▀▀ █▄▄ █ █▄▄ █▀█ ░█░ █ █▄█ █░▀█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █▀▄

 ------------------------------------------------------------------------

  >>  Enjoy your applications without thinking about anything else   <<   
  
 ------------------------------------------------------------------------
      
  Usage:		app [option] [argument]
  
  where option include:
  
  -i, install 	Install a program. This will be taken directly from the
  		repository of the developer (always the latest version):
  		- the installer is stored in /opt/app/programs;
  		- the command is linked to a $PATH;
		- the program is stored in /opt/<program> with a script to
	    	remove this and all the files listed above.
		The icon and the launcher are optional for no-ui programs.
  		APP uses both AppImages and other standalone programs.
  		
  -r, remove	Removes the program and all the other files listed above
  		using the instructions in /opt/app/remove/<program>.
  		Confirmation is required (Y or N, default is N).		 

 ------------------------------------------------------------------------

  Usage:		app [option]
  
  where option include:
  
  -h, help	Prints this message.

  -f, files	Shows the installed programs managed by "APP".

  -s, sync	Updates "APP" to a more recent version.

  -----------------------------------------------------------------------
   
  SITE: https://github.com/ivan-hc/APP-Manager
  
  ' ;;
  '-f'|'files') echo ""; echo $(echo "YOU HAVE INSTALLED "; cd /opt && find -name 'remove' -printf "%h\n" | sort -u | wc -l;
  	echo " STANDALONE PROGRAMS MANAGED BY THE 'APP' COMMAND:"); echo "";
  	cd /opt && find -name 'remove' -printf "%h\n" | sort -u | xargs -n 1 basename; echo "" ;;
  '-i'|'install')
	while [ -n "$1" ]
	do
	case $2 in
	*) for var in $2;
	do cd /opt/app/programs; mkdir tmp; cd tmp; wget $URL/programs/$arch/$2; cd ..; mv ./tmp/$2 ./$2; rmdir ./tmp;
	chmod a+x /opt/app/programs/$2 && exec /opt/app/programs/$2; done
	esac
	shift
	done;;
  '-r'|'remove')
	while [ -n "$1" ]
	do
	case $2 in
	*) for var in $2;
	do read -p "Do you wish to REMOVE this program (y,N)?" yn
		case $yn in
		[Yy]* ) exec /opt/$2/remove; echo ""; echo "Application removed!"; echo ""; break;;
		[Nn]*|* ) echo "Aborted"; exit;; esac done;;
	esac
	shift
	done;;
  '-s'|'sync') echo ""; echo " Updating APP Manager, please wait..."; sleep 1;
  	cd /opt/app; mkdir tmp; cd ./tmp; wget -q $URL/APP-COMMAND && chmod a+x ./app; cd ..;
  	mv /opt/app/tmp/APP-COMMAND /opt/app; rmdir /opt/app/tmp; chown -R $currentuser /opt/app; echo "...done!";;
  *) exec /opt/app/app ;;
esac
