#!/bin/bash
# need to generate a login file or log in with the PIA GUI

# Function to display menu and select a region
select_region() {
    echo "Fetching regions..."
    regions=$(piactl get regions | tail -n +2)

    if [[ -z "$regions" ]]; then
        echo "No regions found. Please ensure piactl is properly configured."
        exit 1
    fi

    echo "Select a region to connect to:"
    local i=1
    while IFS= read -r region; do
        echo "$i) $region"
        ((i++))
    done <<< "$regions"

    read -p "Enter the number of the region you want to connect to: " choice_num

    # Check if the entered number is within range
    num_lines=$(echo "$regions" | wc -l)
    if ! [[ "$choice_num" =~ ^[0-9]+$ ]] || ((choice_num < 1 || choice_num > num_lines)); then
        echo "Invalid choice. Please enter a valid number."
        exit 1
    fi

    # Get the corresponding region based on the selected number
    choice_region=$(echo "$regions" | sed -n "${choice_num}p")

    piactl set region "$choice_region"
    piactl connect
}

# Call the function to select region
select_region

