#!/bin/bash
# Bash Menu Script Example

PS3='Please enter your choice: '
options=("Get audit for last 1 hrs" "Get audit for last 1 day" "Get audit for last 3 days" "Get audit for last 1 week" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Get audit for last 1 hrs")
            echo "Fetching audit  details for last 1 hrs. Please wait ...it may time some time depending upon your logs count"
            #!/bin/bash
            sudo journalctl  -u "dcos-*" -r  --since "1 hour ago"  |grep "UpdateRunSpec\|DeleteRunSpec\|CreateRunSpec" > ~/update
            break
            ;;
        "Get audit for last 1 day")
            echo "Fetching audit  details for last 1 days. Please wait ...it may time some time depending upon your logs count"
            sudo journalctl  -u "dcos-*" -r  --since "1 days ago"  |grep "UpdateRunSpec\|DeleteRunSpec\|CreateRunSpec" > ~/update
            break
            ;;
        "Get audit for last 3 days")
            echo "Fetching audit  details for last 3 days. Please wait ...it may time some time depending upon your logs count"
            sudo journalctl  -u "dcos-*" -r  --since "3 days ago"  |grep "UpdateRunSpec\|DeleteRunSpec\|CreateRunSpec" > ~/update
            break
            ;;
        "Get audit for last 1 week")
            echo "Fetching audit  details for last 1 weeks. Please wait ...it may time some time depending upon your logs count"
            sudo journalctl  -u "dcos-*" -r  --since "1 week ago"  |grep "UpdateRunSpec\|DeleteRunSpec\|CreateRunSpec" > ~/update
            break
            ;;
        "Quit")
            echo "Exitting! Good Bye..."
            exit
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

if [ -s ~/update ]
then
	echo "      Time Stamp              uid               action                 path" > user
cat ~/update |awk -F' ' '{print $9 "=" $11 "="$17 "=" $18 }'|awk -F'=' '{print "  "$2 "          "$4 "        "$6 "            "$8"          " }' >> user
fi
cat user
