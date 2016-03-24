  #!/bin/sh
  # Ping several servers and display Latency, Jitter and Packet Loss 
  #
  # First, create a text file with all servers you want to ping - one host name per line. 
  # The list of voip.ms servers is available at http://wiki.voip.ms/article/Choosing_Server
  myHF="voip-ms-hosts-to-test.txt"
  # Sample file:
  #    toronto.voip.ms
  #    montreal.voip.ms
  #    seattle.voip.ms
  #    chicago.voip.ms
  #    newyork.voip.ms
  #
  echo "============================================"
  printf "%-20s %7s %8s %6s\n" "VoIP Server" "Latency" "Jitter" "Loss"
  echo "============================================"
  cat ${myHF} |\
  while read myLn
  do
     ping -c 3 -i 5 -q $myLn |\
     awk '/^PING / {myH=$2}
          /packet loss/ {myPL=$6}
          /min\/avg\/max/ {
             split($4,myS,"/")
             printf( "%-20s    %3.1f    %1.3f   %4s\n", myH, myS[2], myS[4], myPL)
         }'
  done
  echo "============================================"
