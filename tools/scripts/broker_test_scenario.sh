# Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.

# WSO2 Inc. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at

#    http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.

#!/usr/bin/env bash

destination=""

# get inputs from the user -p <location of the properties file> -d topic/queue
while getopts "hp:d:t:h:v" OPTION
do
     case $OPTION in
         d)
            case $OPTARG in
                queue)
                     destination="queue"
                ;;
                topic)
                    destination="topic"
                ;;
                ?)
                    echo $OPTARG
                    echo "$OPTARG is an invalid destination.JMS destination should be a queue or a topic"
                    exit
                ;;
            esac
            break
            ;;
         h)
            help_text="Welcome to ballerina message broker micro-benchmark tool\n\nUsage:\n\t./broker_test_scenario.sh [command].\n\nCommands\n\t-h  ask for help\n\t-d  set jms destination type queue/topic\n"
            printf "$help_text"
            exit
            ;;
         ?)
            printf "Invalid command.Run ./broker_test_scenario.sh -h for usage.\n"
            exit
            ;;
     esac
done

# execute publisher and consumer at the same time
broker_test_consumer.sh -d "$destination" &
sleep 2
broker_test_publisher.sh -d "$destination" &
wait
