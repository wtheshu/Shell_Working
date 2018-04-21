#!/bin/bash
CMD="nmap -sP "
Ip="10.0.0.0/24"
CMD2="nmap -sS"
$CMD $Ip | awk '/Nmap scan report for/ {print $NF}'
