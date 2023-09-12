#!/bin/bash
repo_url="git@github.com:omeshvalyal/new_project.git"
local_clone_path="/var/lib/jenkins/my_newdir"
source_branch_name="master"
git clone --branch "$source_branch_name" --single-branch https://omeshvalyal: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@github.com/omeshvalyal/new_project.git@"$repo_url" "$local_clone_path"
