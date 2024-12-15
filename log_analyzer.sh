#!/bin/bash

# Couleurs pour rendre la sortie plus lisible
RED='\033[0;31m'         # Rouge : pour les erreurs critiques
GREEN='\033[0;32m'       # Vert : pour les succes ou informations importantes
YELLOW='\033[1;33m'      # Jaune : pour les messages d'erreur generaux ou avertissements
NC='\033[0m'             # Reset : annule les couleurs pour revenir au texte normal

# Fonction pour afficher l'aide
# Appellee lorsque l'utilisateur ne donne pas de commande valide
function display_help() {
        echo "Usage: $0 <command> <logfile>"
        echo ""
        echo "Commands:"
        echo "  aggregate           Aggregate log data by levels and message frequency"
        echo "  temporal_analysis   Perform temporal analysis of the logs"
        echo ""
        exit 0
}

# Fonction pour analyser les logs et agreger les donnees
function aggregate_logs() {
        local file=$1
        filename="$file"      # Nom du fichier a analyser
        timeframe="General"   # Indique un contexte generique pour l'analyse

        # Verifie si le fichier existe et est accessible en lecture
        if [[ ! -f "$file" || ! -r "$file" ]]; then
                echo -e "${YELLOW}Error: File '$file' is either not found or not readable!${NC}"
                exit 1
        fi

        # Compte le nombre d'occurrences pour chaque niveau de log dans le fichier
        trace_count=$(grep -c "\[trace\]" "$file")
        debug_count=$(grep -c "\[debug\]" "$file")
        info_count=$(grep -c "\[info\]" "$file")
        warn_count=$(grep -c "\[warn\]" "$file")
        error_count=$(grep -c "\[error\]" "$file")
        fatal_count=$(grep -c "\[fatal\]" "$file")

        # Trouve les messages les plus frequents et les moins frequents
        most_common_msg=$(awk -F'msg=' '{print $2}' "$file" | sort | uniq -c | sort -nr | head -1 | awk '{$1=""; print $0}' | sed 's/^ *"\(.*\)" *$/\1/')
        most_common_msg_count=$(awk -F'msg=' '{print $2}' "$file" | sort | uniq -c | sort -nr | head -1 | awk '{print $1}')

        least_common_msg=$(awk -F'msg=' '{print $2}' "$file" | sort | uniq -c | sort -n | head -1 | awk '{$1=""; print $0}' | sed 's/^ *"\(.*\)" *$/\1/')
        least_common_msg_count=$(awk -F'msg=' '{print $2}' "$file" | sort | uniq -c | sort -n | head -1 | awk '{print $1}')

        # Affiche les resultats de l'aggregation
        echo -e "=-= Aggregating file $filename $timeframe =-="
        echo ""
        echo -e "Log level counts:"
        echo -e "  - trace: ${GREEN}$trace_count${NC}"
        echo -e "  - debug: ${GREEN}$debug_count${NC}"
        echo -e "  - info: ${GREEN}$info_count${NC}"
        echo -e "  - warn: ${YELLOW}$warn_count${NC}"
        echo -e "  - error: ${RED}$error_count${NC}"
        echo -e "  - fatal: ${RED}$fatal_count${NC}"
        echo ""
        echo -e "Most common message: ${GREEN}\"$most_common_msg\"${NC} (count: ${GREEN}$most_common_msg_count${NC})"
        echo -e "Least common message: ${YELLOW}\"$least_common_msg\"${NC} (count: ${YELLOW}$least_common_msg_count${NC})"
        echo ""
        echo -e "=-= End of report =-="
}

# Fonction pour effectuer une analyse temporelle des logs
function temporal_analysis_logs() {
        local file=$1
        filename="$file"      # Nom du fichier pour cette analyse

        # Verifie si le fichier existe et est accessible en lecture
        if [[ ! -f "$file" || ! -r "$file" ]]; then
                echo -e "${YELLOW}Error: File '$file' is either not found or not readable!${NC}"
                exit 1
        fi

        # Trouve le jour avec le plus d'activite
        most_active_day=$(grep -E "^\[.*\] [0-9]{4}-[0-9]{2}-[0-9]{2}T" "$file" | awk '{print $2}' | cut -d'T' -f1 | sort | uniq -c | sort -nr | head -1 | awk '{print $2}')
        most_active_day=$(date -d "$most_active_day" "+%A")   # Convertit la date en jour de la semaine

        # Trouve l'heure avec le plus d'activite
        most_active_hour=$(awk -F'T' '{print $2}' "$file" | cut -d':' -f1 | sort | uniq -c | sort -nr | head -1 | awk '{print $2"h"}')

        # Trouve l'heure la plus sujette aux erreurs
        most_errors_hour=$(grep -E "\[error\]|\[fatal\]" "$file" | awk -F'T' '{print $2}' | cut -d':' -f1 | sort | uniq -c | sort -nr | head -1 | awk '{print $2"h"}')

        # Affiche les resultats de l'analyse temporelle
        echo -e "=-= $filename temporal analysis =-="
        echo ""
        echo -e "Most active day: ${GREEN}$most_active_day${NC}"
        echo -e "Most active hour: ${GREEN}$most_active_hour${NC}"
        echo -e "Most error-prone hour: ${RED}$most_errors_hour${NC}"
        echo ""
        echo -e "=-= End of report =-="
}

# Verifie les arguments fournis au script
# Le script attend au moins deux arguments : une commande et un fichier
if [ $# -lt 2 ]; then
        if [ $# -eq 0 ]; then
                echo -e "${YELLOW}Error: Missing command and logfile.${NC}"
        fi
        display_help
fi

command=$1
logfile=$2

# Gestion des commandes : appelle la fonction appropriee
case $command in
        aggregate)
                aggregate_logs "$logfile"
                ;;
        temporal_analysis)
                temporal_analysis_logs "$logfile"
                ;;
        *)
                echo -e "${YELLOW}Error: Invalid command '$command'${NC}"
                display_help
                ;;
esac
