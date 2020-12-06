#!/bin/bash
#created by EWHPT4
#reads and splits data from Credit Card Swiper
#March 21st 2019
:<<'info'
    
info
 
clear
cat << "EOF"
                                                                
                          ..-------------------...``````````                                        
                        `.-:-.........---------:::::::::-------....`````````                        
                      `..-:-------------:::::::::::::////////////////////::-----....``````          
                     ......-----:::::::://///////////+++++++oooosssssyyyyyyyyyyyysssoo++-..`        
                   `...````````....-.----:::////++ooossyyyyyyyhhhhhhhhhhhhhhhhhhhhhhhhhhs:-/`       
                 `.--.``````....://:.....----::---:::///++ossyyyyhhhhhhhhhhhhhhhhhhhhhhhs::h.       
                .-...........-.:+o/-.-:+oso/::+++/-:::::::------::://++ooossyyyyhhhhhhhs:+ho        
              .-............--+ss+::+oo+/:-:+sso::osysssyys+-----:////:------:::////++/:sh/         
            `.-...-.------.-:oys++oo+:--:+syy+:-:shhy:--:/:---:+syyyys/:/:------------/hy.          
          `.---..------::-.-+osso+/---:oyhy+::--:+shhy/.---:+syyooyyy/-::-----------:sd+`           
         .------------.-----:/+/:::-:oyhs/:/oo::::+yhho-:/syhs+:+yhy:--------------/hy-             
       .--::::::----....--:::::::::::://:::+oyyyyyyys+/syhyhysoshhy:--------------sd+`              
     `--:////::::::::::::::::::::::::::::::::::::::-:/ooo/:://shhy:-:-------..--/dy-                
    .--://:::::::://///////::::::::::::::::::::::--::---------//+:--------....-sd+                  
    -:::::::////////////////////:::::::::::::::::::::::-:------------......../dy.                   
    `oyyso+//:::::://///////////////:::::::::::::::::::::::::::::------....-ym+                     
      -/+osyhddddhyysoo+////////////:::::::::::::::::::::::::::::::::-..../dy.                      
              `.:+sshdmmmmmmdhyysoo+//:::::::::-------::::::::::::::-...-ym/                        
           `..-:/osyhhhyyyyo+osssyhdddmddhyyso+//::::::----....---...../my.                         
        .---:+syhhhhhhhyyyyyyoo//////+++shhddddmmmmmdhyysoo+/::-...-:ohmo`                          
      `-:/syhhhhhhyyyysssssssoso++--/++/::syyyyyhhhhhddddmmmmmmdhhdmmdho+/-``                       
      `++/+syyyyyyyyyyyssssssssssso+:-`:o:.://oysyyyyyyyyyyyyhhhhhhyyysso/-....`                    
      `:dmy+:/oyhhhhhhhhyyyyyyyyyyyyyyo//:`-/:::-/soosysoossso++ooossyyyssoo+:-...``                
       `.:ohmyo//+syhhhhhhhyyyyyyyyyyyyyyy+-/o--..:--+o+ossso++++++++///+osyyyss+/-...``            
           `-ohdho//+syhhhhhhhhyyyyyyyyyyys+++--/+:.-/:-/+//::://///:::::::/osyyyyys+:-..``         
              `-+ydds+/+osyhhhhhhhhhhyyyys+ooo+/+/:/+o/-.-.--.-::::::::::::::/oyyyyyyyso/:...``     
                 `./sddyo//osyyhhhhhhhhhho+/:/++/://o+``-:::/+..-::::::::::::::+yyyyyyyyyyso/-..    
                    `.:shdho+/+osyhhhhhhhy/::::::::::/:-+-`.--.-`-:-:::::::::::/yyyyyyyyyyyss+-:.   
                       `.:ohdho+/+osyyhhhhyo/:::::::::::::/:-:...--...-::::::::oyyyyyyyysso+/:/s.   
                          ``-+ydds+//+osyhhhyo+/:::::::::::://--o-`.-::`.:.-:/oyyyyyyso+/::/oyy:`   
                              `-/yddy+//+osyhhhys+//::::::::::::/::-....-:/+syhhyyso+/::/syyo/.`    
                                 `./shdyo///+osyhhhyyso++/////////////+osyyhhyyo+/:::+syyo:.`       
                                    `.:ohdho/:/+osyhhhhhhhhhhyyyysyhhhhhhhyso+/:::oyhy+:.`          
                                       `.:+hdho////+oyhhhhhhhhhhhhhhhhhys+/:-:/oyhs/-.`             
                                          ``-+ydhs+////oshhhhhhhhhhhyo+:---+shho/-``                
                                             ``./sddy+//:/+syhhhys+/:--:+yhyo:.`                    
                                                 `./ohdyo::-:::::---:ohdy+-.`                       
                                                    `.:ohdy+/:::/+shhs/-``                          
                                                       `.-+yddddhyo:.``                             
                                                          ``.....``                                                 
                         
EOF
while [ 1 ]
do  


                                                                                         
    echo "Non Credit/Debit cards will give faulty data"
    echo "Swipe Card (Enter to Exit):"
    read data
 
    if [ "$data" = "" ];  then
     
    exit 0
    
    fi
 
   
  
    num="$(echo "$data"|cut -d\B -f2|cut -d\^ -f1)"
    name="$(echo "$data"|cut -d\^ -f2)"
    lname="$(echo "$name"|cut -d\/ -f1)"
    fname="$(echo "$name"|cut -d\/ -f2)"
    exdate="$(echo "$data"|cut -d\^ -f3)"
    sc1="${exdate:4:1}"
    sc2="${exdate:5:1}"
    sc3="${exdate:5:1}"
    exdate="${exdate:2:2}/${exdate:0:2}"
   
    echo "--------------------------------------------------------------------------------------"
    echo "Card Number: $num"
    echo "Card Holder: $fname $lname"
    echo "Experation Date: $exdate"
    echo "Service Code: $sc1$sc2$sc3"

 if [ "$sc1" = "0" ]; then
    echo "No integrated circuit card."
 elif [ "$sc1" = "1" ]; then 
    echo "International, no integrated circuit card."
 elif [ "$sc1" = "2" ]; then
    echo "International, Integrated circuit card!"
 elif [ "$sc1" = "5" ]; then
    echo "National,No integrated circuit card."
 elif [ "$sc1" = "6" ]; then
    echo "National, Integrated circuit card!"
 elif [ "$sc1" = "7" ]; then
    echo "Privet, No integrated circuit card."
 elif [ "$sc1" = "9" ]; then
    echo "Test, No integrated circuit card."
 else
    echo "No data"
 fi

 if [ "$sc2" = "0" ]; then
    echo "Authorization processing : Normal."
 elif [ "$sc2" = "2" ]; then 
    echo "Authorization processing : By user."
 elif [ "$sc2" = "4" ]; then
    echo "Authorization processing : By issuer."
 else
    echo "Authorization processing : No data."
 fi
 
  if [ "$sc3" = "0" ]; then
    echo "No restrictions, PIN required."
 elif [ "$sc3" = "1" ]; then 
    echo "No restrictions, PIN not required."
 elif [ "$sc3" = "2" ]; then
    echo "Goods and services only, PIN not required."
 elif [ "$sc3" = "5" ]; then
    echo "ATM only, PIN required."
 elif [ "$sc3" = "4" ]; then
    echo "Cash only, PIN not required."
 elif [ "$sc3" = "5" ]; then
    echo "Goods and services only, PIN required."
 elif [ "$sc3" = "6" ]; then
    echo "No restrictions, Prompt for PIN if PED presents."
 elif [ "$sc3" = "7" ]; then
    echo "Goods and services only, Prompt for PIN if PED presents."
 else
    echo "No data"
 fi

 
   
    echo "--------------------------------------------------------------------------------------"
done



  
