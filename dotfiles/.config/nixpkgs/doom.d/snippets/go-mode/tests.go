# -*- mode: snippet -*-
# name: test
# uuid:
# key: test
# condition: t
# --
func Test$0(t *testing.T) {
	t.Run("$1", func(t *testing.T) {
		assert.NoError(t, errors.New("Not Implemented"))

	})
}