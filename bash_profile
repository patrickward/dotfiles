# Use everything from .bashrc 
if [ -f ~/.bashrc ];
then
	. ~/.bashrc
fi

# Use
if [ -f ~/.localrc ];
then
	. ~/.localrc
fi

	