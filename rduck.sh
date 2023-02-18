#!/bin/bash

clear # clearing the screen

VERSION="0.3.5"
COUNTER=0

# source ./responses # <-- if you want to externalize your list of responses

responses[0]="Quack Qauck! What's up?" # Always the first response.
responses[1]="Interesting, tell me more."
responses[2]="Please, tell me more."
responses[3]="Neat! Go on."
responses[4]="Could you tell me a bit more about that?"
responses[5]="I'm not sure I understand. Can you tell me more?"
responses[6]="How long do you think that would take?"
responses[7]="Are you super sure about that?"

echo -e "\033[33;43;7m===================================================\033[0m"
echo -e "\033[33;43;7m (o)< ### Rubber Duck Session Initialized ### >(o) \033[0m"
echo -e "\033[33;43;7m>{=}              Quack! Qauck!                {=}<\033[0m"
echo -e "\033[33;43;7m===================================================\033[0m"

echo -e "===================================================" >> session.log
echo -e " (o)< ### Rubber Duck Session Initialized ### >(o) " >> session.log
echo -e ">{=}              Quack! Qauck!                {=}<" >> session.log
echo -e "===================================================" >> session.log

while [[ $input != "bye" ]]; do

    if [[ COUNTER -eq 0 ]]; then
        echo -e "\033[33;43;7m(o)<\033[0m ${responses[0]}"
        echo "(o)<  ${responses[0]}" >> session.log
    else

        prompt=$(jot -r 1 1 7)

        if [[ prompt -eq last_prompt ]]; then
            prompt=$(jot -r 1 1 7) # try again if the prompt is the same as the last one
        fi

        echo -e "\033[33;43;7m(o)<\033[0m ${responses[$prompt]}"
        echo "(o)<  ${responses[$prompt]}" >> session.log
        last_prompt=$prompt
    fi

    echo -n -e "\033[34;44;7m:::>\033[0m "
    read input

    if [[ $input == "bye" ]]; then
        echo -e "\033[33;43;7m(o)< Bye Bye Bye!\033[0m"
        echo -e "(o)<  Bye Bye Bye! Quack! Quack!" >> session.log
        exit 0
    else
        echo ":::> " $input >> session.log
    fi

    contemplating=$(jot -r 1 0.25 2)
    sleep $contemplating &
    PID=$! #simulate contemplation
    echo -e -n "\033[32;42;7mContemplating:\033[0m["
    while kill -0 $PID 2>/dev/null; do
        printf %s "▓"
        sleep 1
    done
    printf "]\n"
    ((COUNTER = COUNTER + 1))
done
