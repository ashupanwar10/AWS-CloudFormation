###################################
#Creator: Ashish Panwar
#Created on: 30-May-2020
###################################

#!/bin/bash
THREAD_DUMP_PATH=/var/tmp/ThreadDump_$(date +%F) #Path where dump will be generated
TimeInterval=180 #In seconds
RegExForProcessID=$(ps aux | grep java | grep NAP | grep -v grep | awk '{print $2}')
mailToSent='dummyuser@dummy.com'
mailSentBy='dummyuser@dummy.com'
ENV="Environment_Name"

echo "checking for $THREAD_DUMP_PATH directory"

if [ ! -d $THREAD_DUMP_PATH ]
then
   rm -rf /var/tmp/ThreadDump_*
   mkdir $THREAD_DUMP_PATH
else
   echo "Directory already present"
fi

for timeCount in {1..10}
do

   echo "**********************************************************************" ${THREAD_DUMP_PATH}/ThreadDump_${processID}.log
   echo "Generating thread dump at $(date) for process ${processID}" >> ${THREAD_DUMP_PATH}/ThreadDump_${processID}.log
   echo "**********************************************************************" ${THREAD_DUMP_PATH}/ThreadDump_${processID}.log

   for processID in ${RegExForProcessID}
   do
      jstack -l ${processID} >> ${THREAD_DUMP_PATH}/ThreadDump_${processID}.log
   done
   sleep ${TimeInterval}
done

# echo "Thread dump generated at ${THREAD_DUMP_PATH}. Please check" | mail -s "Thread dump for ${ENV} generated on $(date)" -r ${mailToSent} ${mailSentBy}