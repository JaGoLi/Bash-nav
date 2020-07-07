#!/bin/bash


#navigation commands
alias gh="cd ~; pdir; ls"
alias gb="cd ..; pdir; ls"

color='\e[1;36m'
nc='\e[0m'
pdir() {
printf "Directory: ${color}%s${nc}\n" "$(pwd)/$1"
}

gt() {
if (( $# == 0 )); then
	pdir; tree -lCL 1 $(ls -d */)
fi

if (( $# == 1 )); then
	if [[ $@ =~ ^- ]]; then
	   if [[ $@ =~ ^-[A-Za-z]*d[A-Za-z]* ]]; then
	  	pdir; tree -lCL 1 $1
		else if [[ $@ =~ ^-[A-Za-z]*a[A-Za-z]* ]]; then
	  		pdir; tree -lCL 1 $1 $(ls -FA | grep "\S*/")
	  		else
			  pdir; tree -lCL 1 $1 $(ls -d */)
		fi
 	fi
	else if [[ $@ = [0-9] ]]; then
	  pdir; tree -lCL $1 $(ls -d */)
	  else
	    pdir $1; tree -lCL 1 $1
	fi
   fi
fi

if (( $# == 2 )); then
	if [[ $@ =~ ^- ]]; then
	  pdir $2; tree -lCL 1 $1 $2
	else if [[ $@ =~ ^[0-9][[:space:]]- ]]; then
	   if [[ $@ =~ ^[0-9][[:space:]]-[A-Za-z]*d[A-Za-z]* ]]; then
	  	pdir; tree -lCL $1 $2
		else if [[ $@ =~ ^[0-9][[:space:]]-[A-Za-z]*a[A-Za-z]* ]]; then
	  		pdir; tree -lCL $1 $2 $(ls -FA | grep "\S*/")
	  		else
	  		  pdir; tree -lCL $1 $2 $(ls -d */)
		fi
 	fi
	   else if [[ $@ =~ ^[0-9][[:space:]] ]]; then
	    pdir $2; tree -lCL $1 $2
	fi
    fi
  fi	  
fi

if (( $# == 3 )); then
	pdir $3; tree -lCL $1 $2 $3
fi

if (( $# >= 4 )); then
	echo "gt: too many arguments"
fi
}

gd() {
if (( $# == 1 )); then
	if [[ $@ = -* ]]; then
	  pdir; ls $1
	else 
	  cd $1; pdir; ls
    fi
  else
	if (( $# >= 3 )); then
	  echo "gd: too many arguments"
	else
	  if (( $# == 0 )); then
		pdir; ls
	  else
	  	cd $2; pdir; ls $1
	fi
   fi
fi
}

