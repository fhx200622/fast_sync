#!/bin/bash 

read user1
read user2
read user3

ip1 =
pa1 = 
getip user1
transfile ip1 pa1

getip(){
    loacl indexip = expr index $1 "@"
    loacl indexpa = expr index $1 "\s"
    loacl length = expr length $1
    loacl a = indexip + 1
    local b = indexpa + 1
    local l1 = indexpa - indexip - 1
    local l2 = length - indexpa
    ip1 = expr substr $1 $a $l1
    pa1 = expr substr $1 $b $l2
}

transfile(){
    
}

    

ssh origin@10.10.11.61
