BEGIN {
	show = 1
}

/^#\+[bB][eE][gG][iI][nN]_[lL][aA][tT][eE][xX]/ {
	show = 0
}

/^#\+[eE][nN][dD]_[lL][aA][tT][eE][xX]/ {
	show = 1
}

/^#\+/ {
	next  
}

{
	if (show) {
		gsub(/\[\[[^\]]*\]\]/, "", $0)
		gsub(/\\cite{[^}]*}/, "", $0)
		gsub(/\\ref{[^}]*}/, "", $0)
		print $0
	}
}
