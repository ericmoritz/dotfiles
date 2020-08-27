# -*- mode: snippet -*-
# name: iferr2
# key: iferr2
# --
if err != nil {
	return $1, fmt.Errorf("$2: %w", err)
}
