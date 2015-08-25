This is an extension of emms-player-simple.el for mpv JSON IPC.
It provides macros and functions for defining emms simple players of mpv.
emms-player-simple-mpv-control-functions.el provides other functions to control mpv.

Further information is available from:
https://github.com/momomo5717/emms-player-simple-mpv


Setup:

(require 'emms-player-simple-mpv)
If you use other control functions,
(require 'emms-player-simple-mpv-control-functions)

Usage:

An example of setting like emms-player-mplayer.el
`emms-player-my-mpv' is defined in this case.
(define-emms-simple-player-mpv my-mpv '(file url streamlist playlist)
    (concat "\\`\\(http[s]?\\|mms\\)://\\|"
            (apply #'emms-player-simple-regexp
                   "aac" "pls" "m3u"
                   emms-player-base-format-list))
    "mpv" "--no-terminal" "--force-window=no" "--audio-display=no")

(emms-player-simple-mpv-add-to-converters
 'emms-player-my-mpv "." '(playlist)
 (lambda (track-name) (format "--playlist=%s" track-name)))

(add-to-list 'emms-player-list 'emms-player-my-mpv)
