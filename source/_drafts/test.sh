for line in `cat export_reprint.txt`;
do

    id=`echo $line | awk '{print $1}'`
    echo $id
    exit
done
