phrase="Ceci est une phrase : de test"
echo ${#phrase} 
echo ${phrase} | cut -f1 -d":"
echo ${phrase} |cut -f2 -d":"
