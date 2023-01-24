#!/bin/bash

# function to display list of possible keys and their description
display_keys() {
    echo "Possible keys and their description:"
    echo "--all: Displays the IP addresses and symbolic names of all hosts in the current subnet"
    echo "--target: Displays a list of open system TCP ports"
}

# function to display IP addresses and symbolic names of all hosts in the current subnet
display_all() {
    echo "IP addresses and symbolic names of all hosts in the current subnet:"
    arp -a
}

# function to display a list of open system TCP ports
display_target() {
    echo "List of open system TCP ports:"
    netstat -tuln | grep -E '^tcp'
}

if [ $# -eq 0 ]; then
    display_keys
else
    while [ $# -gt 0 ]; do
        case $1 in
            --all)
                display_all
                shift
                ;;
            --target)
                display_target
                shift
                ;;
            *)
                echo "Invalid key. Use --help for a list of possible keys"
                exit 1
                ;;
        esac
    done
fi

