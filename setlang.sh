#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo ""
printf "${CYAN}Choose a language for the frontend:${NC}\n"
languages=("English" "German" "Custom")
select language in "${languages[@]}"; do
    case $language in
        "German")
            # it's the default.
            printf "${GREEN}German${NC} set.\n"
        break
            ;;
        "English")
            sed -i "s/'de'/'en'/" user/config/{system,site}.yaml
            printf "${GREEN}English${NC} set.\n"
        break
            ;;
        "Custom")
            read -p "Whats the language code (two character)?: " customlang
            if [ "$customlang" ]
            then
                sed -i "s/'de'/'$customlang'/" user/config/{system,site}.yaml
                printf "${GREEN}$customlang${NC} set.\n"
                printf "${RED}You will find information about adding translations for unsupported languages in the README.md${NC}.\n"
            fi
        break
            ;;
	"none")
        break
        ;;
        *) echo "invalid option $REPLY";;
    esac
done