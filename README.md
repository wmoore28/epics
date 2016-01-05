#HPS EPICS

## Versions
* EPICS_BASE 3.14.12.5
* EPICS_HOST_ARCH linux-x86_64 (rhel7 32/64-bit, VxWorks 5.5 PPC)
* synApps 5.8

## Getting Started
To get a github repository setup for HPS EPICS developement:
* Create a github account and login
* Create a new repository using the "+" near the top right of the webpage, don't check "Initialize Repository with a README"
* On your desktop:
```
mkdir <newdir>
cd <newdir>
git init
git remote add origin https://github.com/<username>/<new-repo-name>
git remote add hps-epics https://github.com/wmoore28/epics
git pull hps-epics master
git push -u origin master
```
* Edit/add files then commit the changes.  Push to your remote repository (on github).
```
git add <changed files>
git commit -m "Meaningful comments about changes"
git push
```

## Submit code to HPS EPICS
I recommend doing a pull from the wmoore28/epics first, getting updates from others *(See: Staying in sync)*

On github, navigate to your repository with the changes you want to submit.
* Switch to the branch with the changes
* Click the **Compare, review, create a pull request** button
* Ensure the branches being compared are correct and review changes **(submit to wmoore28/epics:develop)**
* Click **Create pull request**

## Staying in sync
Add a remote to the official repository (view remotes with 'git remote -v')
```
git remote add hps-epics https://github.com/wmoore28/epics
# get updates from remote branch, most likely master or develop
git pull hps-epics master
# if everything looks good...push changes to your repo
git push origin master
```

## Using branches
If doing much of a feature add or rework, use a branch.
```
# Clone your repo.  Example:
git clone https://github.com/wmoore28/epics.git <local-dir>  # defaults to epics
cd <local-dir>
git checkout -b <branch-name>    # omit -b if using an existing branch
```
Edit/add code then commit the changes.  Once ready, push changes to your remote branch (on github).
```
git add <changed files>
git commit -m "Meaningful comments about changes"
git push origin <branch-name>
```
