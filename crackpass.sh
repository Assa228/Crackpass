#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Utilisation : $0 <fichier.rar, fichier.zip ou fichier.pdf>"
  exit 1
fi

fichier="$1"
extension="${fichier##*.}"

if [ "$extension" == "rar" ]; then
  rar2john "$fichier" > hash
  john --wordlist=/usr/share/wordlists/rockyou.txt hash
elif [ "$extension" == "zip" ]; then
  zip2john "$fichier" > hash
  john --wordlist=/usr/share/wordlists/rockyou.txt hash
elif [ "$extension" == "pdf" ]; then
  pdfcrack --wordlist=/usr/share/wordlists/rockyou.txt "$fichier"
else
  echo "Extension de fichier non supportée : $extension"
  exit 1
fi

# Nettoyer le fichier hash après utilisation
rm -f hash
