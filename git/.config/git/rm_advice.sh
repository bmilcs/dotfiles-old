#!/bin/sh
#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#              GIT GLOBAL  ADVICE REMOVAL [./rm_advice.sh]
#────────────────────────────────────────────────────────────
source _head
#────────────────────────────────────────────────────────────
# 
#────────────────────────────────────────────────────────────
git config --global advice.pushUpdateRejected
git config --global advice.pushNonFFCurrent
git config --global advice.pushNonFFMatching
git config --global advice.pushAlreadyExists
git config --global advice.pushFetchFirst
git config --global advice.pushNeedsForce
git config --global advice.statusHints
git config --global advice.statusUoption
git config --global advice.commitBeforeMerge
git config --global advice.resolveConflict
git config --global advice.implicitIdentity
git config --global advice.detachedHead
git config --global advice.amWorkDir
git config --global advice.rmHints

#  advice.*
#  -------------------------
#  fetchShowForcedUpdates
#     Advice shown when git-fetch(1) takes a long time to calculate forced updates
#     after ref updates, or to warn that the check is disabled.
#  pushUpdateRejected
#     Set this variable to false if you want to disable pushNonFFCurrent,
#     pushNonFFMatching, pushAlreadyExists, pushFetchFirst, pushNeedsForce, and
#     pushRefNeedsUpdate simultaneously.
#  pushNonFFCurrent
#     Advice shown when git-push(1) fails due to a non-fast-forward update to the
#     current branch.
#  pushNonFFMatching
#     Advice shown when you ran git-push(1) and pushed matching refs explicitly (i.e.
#     you used :, or specified a refspec that isn’t your current branch) and it
#     resulted in a non-fast-forward error.
#  pushAlreadyExists
#     Shown when git-push(1) rejects an update that does not qualify for
#     fast-forwarding (e.g., a tag.)
#  pushFetchFirst
#     Shown when git-push(1) rejects an update that tries to overwrite a remote ref
#     that points at an object we do not have.
#  pushNeedsForce
#     Shown when git-push(1) rejects an update that tries to overwrite a remote ref
#     that points at an object that is not a commit-ish, or make the remote ref point
#     at an object that is not a commit-ish.
#  pushUnqualifiedRefname
#     Shown when git-push(1) gives up trying to guess based on the source and
#     destination refs what remote ref namespace the source belongs in, but where we
#     can still suggest that the user push to either refs/heads/* or refs/tags/* based
#     on the type of the source object.
#  pushRefNeedsUpdate
#     Shown when git-push(1) rejects a forced update of a branch when its
#     remote-tracking ref has updates that we do not have locally.
#  statusAheadBehind
#     Shown when git-status(1) computes the ahead/behind counts for a local ref
#     compared to its remote tracking ref, and that calculation takes longer than
#     expected. Will not appear if status.aheadBehind is false or the option
#     --no-ahead-behind is given.
#  statusHints
#     Show directions on how to proceed from the current state in the output of git-
#     status(1), in the template shown when writing commit messages in git-commit(1),
#     and in the help message shown by git-switch(1) or git-checkout(1) when switching
#     branch.
#  statusUoption
#     Advise to consider using the -u option to git-status(1) when the command takes
#     more than 2 seconds to enumerate untracked files.
#  commitBeforeMerge
#     Advice shown when git-merge(1) refuses to merge to avoid overwriting local
#     changes.
#  resetQuiet
#     Advice to consider using the --quiet option to git-reset(1) when the command
#     takes more than 2 seconds to enumerate unstaged changes after reset.
#  resolveConflict
#     Advice shown by various commands when conflicts prevent the operation from being
#     performed.
#  sequencerInUse
#     Advice shown when a sequencer command is already in progress.
#  implicitIdentity
#     Advice on how to set your identity configuration when your information is guessed
#     from the system username and domain name.
#  detachedHead
#     Advice shown when you used git-switch(1) or git-checkout(1) to move to the detach
#     HEAD state, to instruct how to create a local branch after the fact.
#  checkoutAmbiguousRemoteBranchName
#     Advice shown when the argument to git-checkout(1) and git-switch(1) ambiguously
#     resolves to a remote tracking branch on more than one remote in situations where
#     an unambiguous argument would have otherwise caused a remote-tracking branch to
#     be checked out. See the checkout.defaultRemote configuration variable for how to
#     set a given remote to used by default in some situations where this advice would
#     be printed.
#  amWorkDir
#     Advice that shows the location of the patch file when git-am(1) fails to apply
#     it.
#  rmHints
#     In case of failure in the output of git-rm(1), show directions on how to proceed
#     from the current state.
#  addEmbeddedRepo
#     Advice on what to do when you’ve accidentally added one git repo inside of
#     another.
#  ignoredHook
#     Advice shown if a hook is ignored because the hook is not set as executable.
#  waitingForEditor
#     Print a message to the terminal whenever Git is waiting for editor input from the
#     user.
#  nestedTag
#     Advice shown if a user attempts to recursively tag a tag object.
#  submoduleAlternateErrorStrategyDie
#     Advice shown when a submodule.alternateErrorStrategy option configured to "die"
#     causes a fatal error.
#  addIgnoredFile
#     Advice shown if a user attempts to add an ignored file to the index.
#  addEmptyPathspec
#     Advice shown if a user runs the add command without providing the pathspec
#     parameter.
