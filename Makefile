all:
	stow --verbose --target=$$HOME --restow */
all-adopt:
	stow --verbose --target=$$HOME --adopt --restow */
delete:
	stow --verbose --target=$$HOME --delete */
