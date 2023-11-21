#!/bin/sh

# Function to check URL validity
is_valid_url() {
  URL=$1
  if curl --output /dev/null --silent --head --fail "$URL"; then
    echo "true"
  else
    echo "false"
  fi
}

# Request project name
while true; do
    read -p "Enter project name: " PROJECT_NAME
    if [ -z "$PROJECT_NAME" ]; then
        echo "Error: Project name cannot be empty."
    else
        break
    fi
done

# Request GitHub project URL
while true; do
    read -p "Enter GitHub project URL: " REPO_URL
    if [ -z "$REPO_URL" ]; then
        echo "Error: GitHub project URL cannot be empty."
    elif [ $(is_valid_url $REPO_URL) == "false" ]; then
        echo "Error: Invalid GitHub project URL."
    else
        break
    fi
done

# Create new folder for the project
echo "Creating folder $PROJECT_NAME"
mkdir $PROJECT_NAME

# Navigate to project folder
echo "Navigating to folder $PROJECT_NAME"
cd $PROJECT_NAME

# Initialize new Git repository
echo "Initializing Git repository"
git init

# Add all project files to the index
echo "Adding files to the index"
git add .

# Create commit with message "Initial commit"
echo "Creating commit"
git commit -m "Initial commit"

# Add GitHub remote repository to the local repository
echo "Adding remote repository"
git remote add origin $REPO_URL --force

# Push local commits to remote repository
echo "Pushing commits to GitHub"
git push -u origin master

echo "Process completed!"