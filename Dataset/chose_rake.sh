#!bin/bash

file=SATraces.TXT
cp CFM5.3_traces.lonLat CFM5.3_traces_lonLat.txt
outfile=CFM5.3_traces_lonLat.txt
sed -i 's/"/ /g' $outfile
   for event in $(cat $file | awk '{print NR}')
      do
	 name=`cat $file | awk 'NR=="'"$event"'"{print $1}'`
	 strike=`cat $file | awk 'NR=="'"$event"'"{print $2}'`
	 dip=`cat $file | awk 'NR=="'"$event"'"{print $3}'`
         long=`cat $file | awk 'NR=="'"$event"'"{print $4}'`
	 rake=`cat $file | awk 'NR=="'"$event"'"{print $5}'` 
	 if [ $rake = rlss ]; then
 	    sed -i "s/$name/$strike $dip 170/g"  $outfile
         elif [ $rake = llss ]; then
            sed -i "s/$name/$strike $dip 10/g"  $outfile
	 elif [ $rake = n ]; then
            sed -i "s/$name/$strike $dip -70/g"  $outfile
         elif [ $rake = r ]; then
            sed -i "s/$name/$strike $dip 80/g"  $outfile
         elif [ $rake = orlr ]; then
            sed -i "s/$name/$strike $dip 120/g"  $outfile
         elif [ $rake = ollr ]; then
            sed -i "s/$name/$strike $dip 40/g"  $outfile
	 elif [ $rake = orln ]; then
            sed -i "s/$name/$strike $dip -110/g"  $outfile
         elif [ $rake = olln ]; then
            sed -i "s/$name/$strike $dip -20/g"  $outfile
         fi
      done
