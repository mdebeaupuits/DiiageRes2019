#!/bin/bash
#calc.sh
#Operation mathematique simple

function op () {
    case $2 in
        +) let calc=$1+$3
	;;
        -) let calc=$1-$3
	;;
        *) let calc=$1*$3
	;;
        /) let calc=$1/$3
	;;
        *)
            echo "bad parameter"
	;;
    esac
}
op $1 $2 $3
echo "$calc"
