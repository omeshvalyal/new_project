#!/bin/bash

repo_url="git@github.com:omeshvalyal/new_project.git"
local_clone_path="/var/lib/jenkins/my_work"
source_branch_name="master"
# current_version="release/$2"
# echo "source_branch_name: $source_branch_name"
# echo "current_version: $current_version"

# Remove the cloned repository if it exists
if [ -d "$local_clone_path" ]; then
  rm -rf "$local_clone_path"
fi

# Clone the repository
git clone --branch "$source_branch_name" --single-branch "$repo_url" "$local_clone_path"

# Navigate to the cloned repository
cd "$local_clone_path"

source_folder="template_$2"
destination_folder="$2"

if [ -d "$destination_folder" ]; then
  echo "The folder '$destination_folder' already exists!!"
else
  echo "The folder '$destination_folder' does not exist!!"
  # Copy the template version folder to the destination renaming it with current version
  cp -r "$source_folder" "$destination_folder"
  echo "The folder '$destination_folder' has been created!!"
fi

source_file_list=("changelog_$1_installer_isolated.xml" "changelog_$1_installer_mssp.xml" "changelog_$1_mssp.xml" "changelog_$1.xml")
destination_file_list=("changelog_$2_installer_isolated.xml" "changelog_$2_installer_mssp.xml" "changelog_$2_mssp.xml" "changelog_$2.xml")

for ((i=0; i<${#source_file_list[@]}; i++)); do
  source_file="${source_file_list[i]}"
  destination_file="${destination_file_list[i]}"
  
  if [ -f "$destination_file" ]; then
    echo "The file '$destination_file' exists in the directory."
  else
    echo "The file '$destination_file' does not exist in the directory!!"
    cp "$source_file" "$destination_file"
    echo "The file '$destination_file' has been created!!"
  fi
done

template_file_list=("changelog_installer_isolated.xml" "changelog_installer_mssp.xml" "changelog_mssp.xml" "changelog.xml")

for ((i=0; i<${#template_file_list[@]}; i++)); do
  template_source_file="${template_file_list[i]}"
  destination_file="${destination_file_list[i]}"
  
  # Remove last tag from each file
  sed -i '$ d' "$destination_file"
  
  # Append the content from the template file
  cat "$template_source_file" | sed 's/^/\t/' >> "$destination_file"
  
  # Add the last tag back to the file
  echo "</databaseChangeLog>" >> "$destination_file"
  
  # Replace "current_version" with the actual passed version string
  sed -i "s/current_version/$2/g" "$destination_file"
done

# Commit the changes
git add .
git commit -m "Created folder and changelog files for $2"

# Push the changes back to the repository
git push
