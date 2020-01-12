# -*- mode: snippet -*-
# name: trun
# key: trun		
# --
t.Run("$1", func(t *testing.T) {
	$2assert.NoError(t, errors.New("Not Implemented"))
})
