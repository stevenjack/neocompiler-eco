#!/bin/bash

# $1 == HASH
# import contract hash.avm "params" 01 False False

if (( $# == 6 )); then
   lhash=`echo "$1" | base64 --decode`
   #echo "HASH: $lhash"
   #echo "code: $2"
   cd /opt/neo-python/
   echo "$2" | base64 --decode | xxd -p -r > $lhash.avm
   parm=`echo $3 | base64 --decode`
   rv=`echo $4 | base64 --decode`
   op1=`echo $5 | base64 --decode`
   op2=`echo $6 | base64 --decode`


   stropen=`echo "open wallet w1.wallet" | xxd -p`
   strrebuild=`echo "wallet rebuild" | xxd -p`
   strshowwallet=`echo "wallet" | xxd -p`

   #echo "open: $stropen"
   strimport=`echo "import contract $lhash.avm $parm $rv $op1 $op2" | xxd -p -c 256`
   #echo "open: $strimport"
   strexit=`echo "exit" | xxd -p`
   strsearch=`echo "contract $lhash" | xxd -p -c 256`
   strinvoke=`echo "testinvoke $lhash" | xxd -p -c 256`

   #echo "exit: $strexit"
   #python3 unsafeprompt.py -p -e $stropen,$strimport,$strexit > $lhash.importout
   python3 unsafeprompt.py -p -e $strexit,$strimport,$strshowwallet,$strrebuild,$stropen
   #python3 unsafeprompt.py -p -e $strexit,$strinvoke,$strshowwallet,$strrebuild,$stropen


   cat $lhash.import

   #strcmd="python3 unsafeprompt.py -p -e "
fi

#example: ./execimportcontract.sh M2ZlMTY2ZTczMzIwYTVlZDNmZTg0YTFkNjhlMmRlMmE2YTk1YmJiZAo= MDBjNTZiNjE2Yzc1NjYK IiIK MDEK RmFsc2UK RmFsc2UK
#outside: docker exec -t neo-privnet-with-gas dash -i -c "./execimportcontract.sh M2ZlMTY2ZTczMzIwYTVlZDNmZTg0YTFkNjhlMmRlMmE2YTk1YmJiZAo= MDBjNTZiNjE2Yzc1NjYK IiIK MDEK RmFsc2UK RmFsc2UK" > saida.log
