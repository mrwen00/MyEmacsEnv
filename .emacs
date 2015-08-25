

;; ================================================================
(package-initialize)
(require 'ace-jump-mode)
(require 'auto-complete)
(require 'ace-isearch)
(require 'highlight-symbol)
(global-ace-isearch-mode +1)
(global-linum-mode 1)

;; ===== Turn on Web mode =====
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; ===== Change background color =====
(add-to-list 'default-frame-alist '(foreground-color . "#E0DFDB"))
(add-to-list 'default-frame-alist '(background-color . "#000000"))

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))

;; ====================================================================
;; Emacs key binding
(global-set-key (kbd "C-u") 'kill-whole-line)
(global-set-key (kbd "M-p") 'backward-sentence)
(global-set-key (kbd "M-n") 'forward-sentence)
(global-set-key (kbd "M-a") 'beginning-of-buffer)
(global-set-key (kbd "M-e") 'end-of-buffer)
(global-set-key (kbd "M-l") 'backward-kill-word)
(global-set-key (kbd "C-x c") 'ace-jump-char-mode)
(global-set-key (kbd "<f3>") 'highlight-selected-region)
(global-set-key (kbd "M-<f3>") 'highlight-symbol-remove-all)

;; ====================================================================
;; Highlight feature
(defun highlight-selected-region()
  "Highlight text in selected region and other places."
  (interactive)
  (if (region-active-p)
      (progn
	(highlight-symbol-add-symbol (buffer-substring (region-beginning) (region-end)))
	(keyboard-escape-quit))
    (highlight-symbol-at-point)))



;; ====================================================================
;; Set ace-isearch jump
;; Description: You need to use isearch by C-g, type the word you search
;;              and C-x w your cursor will jump to the word you select
(custom-set-variables
 '(ace-isearch-input-length 7)
 '(ace-isearch-jump-delay 0.3)
 '(ace-isearch-function 'avy-goto-char)
 '(ace-isearch-use-jump 'printing-char))

(define-key isearch-mode-map (kbd "C-x w") 'ace-isearch-jump-during-isearch)

;; ====================================================================
;; Hide toolbar at startup
(tool-bar-mode -1)

;; =================================================================
;; keeping related buffers together with elscreen
;; Ref:
;;   http://emacs-fu.blogspot.com/2009/07/keeping-related-buffers-together-with.html

(load "elscreen" "ElScreen" )

;; Windowskey+F9 creates a new elscreen, Windowskey+F10 kills it
(global-set-key (kbd "<M-f9>"    ) 'elscreen-create)
(global-set-key (kbd "<M-f10>"  ) 'elscreen-kill)


;; Windowskey+PgUP/PgDown switches between elscreens
(global-set-key (kbd "<s-prior>") 'elscreen-previous)
(global-set-key (kbd "<s-next>")  'elscreen-next)
(global-set-key (kbd "M-0")  '(lambda() (interactive) (hajime-startup)))

(defvar is-hajime-startup nil
  "Indicate if the hajime-startup process has been activated or not.")

(defun hajime-startup ()
  "Doing some customization at startup time."
  (interactive)
  (unless is-hajime-startup
    (setq is-hajime-startup t)
    (hajime-elscreen))
  )

;; ;; startup settings
(defun hajime-elscreen ()
  (interactive)
  (elscreen-start)
  (elscreen-create)
  (elscreen-screen-nickname "box")
  (elscreen-create)
  (elscreen-screen-nickname "box")
  (elscreen-create)
  (elscreen-screen-nickname "box")
  (elscreen-create)
  (elscreen-screen-nickname "box")
  (elscreen-create)
  (elscreen-screen-nickname "box")
  (elscreen-create)
  (elscreen-screen-nickname "box")
  (elscreen-create)
  (elscreen-screen-nickname "shell")
  (elscreen-create)
  (elscreen-screen-nickname "reserved")
  (elscreen-create)
  (elscreen-screen-nickname "reserved")

  (elscreen-goto 0)
  (elscreen-kill)

  ;; keybinding for switching workspaces
  (global-set-key "\M-1" '(lambda () (interactive) (elscreen-goto 1)))
  (global-set-key "\M-2" '(lambda () (interactive) (elscreen-goto 2)))
  (global-set-key "\M-3" '(lambda () (interactive) (elscreen-goto 3)))
  (global-set-key "\M-4" '(lambda () (interactive) (elscreen-goto 4)))
  (global-set-key "\M-5" '(lambda () (interactive) (elscreen-goto 5)))
  (global-set-key "\M-6" '(lambda () (interactive) (elscreen-goto 6)))
  (global-set-key "\M-7" '(lambda () (interactive) (elscreen-goto 7)))
  (global-set-key "\M-8" '(lambda () (interactive) (elscreen-goto 8)))
  (global-set-key "\M-9" '(lambda () (interactive) (elscreen-goto 9)))

  ;; keybinding for moving a buffer to a specific workspace
  (global-set-key (kbd "<M-S-f1>") '(lambda () (interactive) (hajime-move-buffer-to-elscreen 1)))
  (global-set-key (kbd "<M-S-f2>") '(lambda () (interactive) (hajime-move-buffer-to-elscreen 2)))
  (global-set-key (kbd "<M-S-f3>") '(lambda () (interactive) (hajime-move-buffer-to-elscreen 3)))
  (global-set-key (kbd "<M-S-f4>") '(lambda () (interactive) (hajime-move-buffer-to-elscreen 4)))
  (global-set-key (kbd "<M-S-f5>") '(lambda () (interactive) (hajime-move-buffer-to-elscreen 5)))
  (global-set-key (kbd "<M-S-f6>") '(lambda () (interactive) (hajime-move-buffer-to-elscreen 6)))
  (global-set-key (kbd "<M-S-f7>") '(lambda () (interactive) (hajime-move-buffer-to-elscreen 7)))
  (global-set-key (kbd "<M-S-f8>") '(lambda () (interactive) (hajime-move-buffer-to-elscreen 8)))
  (global-set-key (kbd "<M-S-f9>") '(lambda () (interactive) (hajime-move-buffer-to-elscreen 9)))
)

;; =================================================================
;; insert separator line in the form of comment in respect to 'major-mode
(setq hajime-var-separator-char-number 65)

(defun hajime-char-multiply (char numberOfChars)
  (cond ((<= numberOfChars 0) "")
	((= numberOfChars 1) char)
	((> numberOfChars 1)
	 (let ((tmp-s (hajime-char-multiply char (/ numberOfChars 2))))
	   (if (oddp numberOfChars) (concat char tmp-s tmp-s)
	     (concat tmp-s tmp-s))))))

(global-set-key (kbd "M-<f6>")
		'(lambda () (interactive)
		   (let ((comment-char-begin ";; ")
			 (comment-char-end nil))
		     (cond
		      ((or (eq major-mode 'org-mode)
			   (eq major-mode 'python-mode)
			   (eq major-mode 'ruby-mode))
		       (setq comment-char-begin "# "))
		      ((or (eq major-mode 'js-mode)
			   (eq major-mode 'jde-mode)
			   (eq major-mode 'java-mode))
		       (setq comment-char-begin "// "))
		      ((eq major-mode 'sql-mode)
		       (progn
			 (setq comment-char-begin "/* ")
			 (setq comment-char-end " */")
			 ))
		      ((or (eq major-mode 'markdown-mode)
			   (eq major-mode 'html-mode)
			   (eq major-mode 'nxml-mode))
		       (progn
			 (setq comment-char-begin "<!-- ")
			 (setq comment-char-end " -->")))
		      )
		     (insert (concat comment-char-begin
				     (hajime-char-multiply "=" hajime-var-separator-char-number)
				     comment-char-end)))))

;; =================================================================
;; Jump to frequently used files

(global-set-key (kbd "<f8> 0") '(lambda() (interactive) (find-file "~/.emacs")))
(global-set-key (kbd "<f8> 1") '(lambda() (interactive) (find-file "E:\\MRWEN-DATA\\00 STUDY")))

;; =================================================================

;; Install jshint for Nodejs
;;(add-to-list 'load-path "~/jshint-mode")
;;(require 'flymake-jshint)
;;(add-hook 'javascript-mode-hook
;;     (lambda () (flymake-mode t)))

;; Turns on flymake for all files which have a flymake mode
;;(add-hook 'find-file-hook 'flymake-find-file-hook)

;; =================================================================
;; Add auto-complete-mode
(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-20150618.1949")
; Load the default configuration
(require 'auto-complete-config)
; Make sure we can find the dictionaries
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20150618.1949/dict")
; Use dictionaries by default
(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))
(global-auto-complete-mode t)
; Start auto-completion after 2 characters of a word
(setq ac-auto-start 2)
; case sensitivity is important when finding matches
(setq ac-ignore-case nil)

;; =================================================================
;; install flymake-jslint
(require 'flymake-jslint)
    (add-hook 'js-mode-hook 'flymake-jslint-load)
(add-to-list 'load-path "~/.emacs.d/elpa/flymake-cursor")
;; Nice Flymake minibuffer messages
;;(require 'flymake-cursor)
;;(require 'flymake-easy)
;; =================================================================

;; install jshint
;;(add-to-list 'load-path "~/.emacs.d/GitFile/jshint-mode")
;;(require 'flymake-jshint)
;;(add-hook 'js-mode-hook
;;     (lambda () (flymake-mode t)))

;;(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
;;	(setq exec-path
;;	      '(
;;		"/usr/local/bin"
;;		"/usr/bin"
;;		))

;; =================================================================

;; install js-comint
;;(require 'js-comint)
;;(setq inferior-js-program-command "/usr/bin/java org.mozilla.javascript.tools.shell.Main")
;;(add-hook 'js2-mode-hook '(lambda () 
;;			    (local-set-key "\C-x\C-e" 'js-send-last-sexp)
;;			    (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
;;			    (local-set-key "\C-cb" 'js-send-buffer)
;;			    (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
;;			    (local-set-key "\C-cl" 'js-load-file-and-go)
;;			    ))

;; =================================================================
;; install emms player
;; Reference Link: http://www.emacswiki.org/emacs/EMMS
;;                 http://wikemacs.org/wiki/Media_player
(add-to-list 'load-path "~/.emacs.d/GitFile/emms/lisp/")
(add-to-list 'load-path "~/.emacs.d/GitFile/mplayer/")
(add-to-list 'exec-path "~/.emacs.d/GitFile/mplayer/")
(require 'emms)
(require 'emms-setup)
        (emms-standard)
        (emms-default-players)
(require 'emms-player-mplayer)
(require 'emms-player-simple)
(require 'emms-source-file)
(require 'emms-source-playlist)
(setq emms-player-list '(emms-player-mpg321 
			 emms-player-ogg123 
			 emms-player-mplayer)
      emms-source-list '((emms-directory-tree "D:/My Music/")))

;; =================================================================
;; install magit
(require 'magit)
(add-to-list 'exec-path "C:/Program Files/Git/cmd/")

;; =================================================================
;; install flymake-html

(defun flymake-html-init ()
       (let* ((temp-file (flymake-init-create-temp-buffer-copy
                          'flymake-create-temp-inplace))
              (local-file (file-relative-name
                           temp-file
                           (file-name-directory buffer-file-name))))
         (list "tidy" (list local-file))))

(defun flymake-html-load ()
  (interactive)
  (when (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
    (set (make-local-variable 'flymake-allowed-file-name-masks)
         '(("\\.html\\|\\.ctp\\|\\.ftl\\|\\.jsp\\|\\.php\\|\\.erb\\|\\.rhtml" flymake-html-init))
         )
    (set (make-local-variable 'flymake-err-line-patterns)
         ;; only validate missing html tags
         '(("line \\([0-9]+\\) column \\([0-9]+\\) - \\(Warning\\|Error\\): \\(missing <\/[a-z0-9A-Z]+>.*\\|discarding unexpected.*\\)" nil 1 2 4))
         )
    (flymake-mode t)))

(add-hook 'web-mode-hook 'flymake-html-load)
(add-hook 'html-mode-hook 'flymake-html-load)
(add-hook 'nxml-mode-hook 'flymake-html-load)
(add-hook 'php-mode-hook 'flymake-html-load)

;; =================================================================
;; install flymake-jslint
;;(add-to-list 'load-path "~/.emacs.d/GitFile/jslint/")
;;(require 'flymake)
;;(require 'flymake-jslint)
;;(add-hook 'js-mode-hook 'flymake-jslint-load)
;;(add-hook 'javascript-mode-hook
;;          (lambda () (flymake-mode 1)))

;; =================================================================
;; set controlling the buffer
(global-set-key (kbd "C-x p") 'windmove-up)
(global-set-key (kbd "C-x n") 'windmove-down)
(global-set-key (kbd "C-x e") 'windmove-right)
(global-set-key (kbd "C-x a") 'windmove-left)

;; =================================================================
;; set window number. Use: C-x C-j number_of_buffer
(add-to-list 'load-path "~/.emacs.d/GitFile/window-number/")
 (autoload 'window-number-mode "window-number"
   "A global minor mode that enables selection of windows according to
 numbers with the C-x C-j prefix.  Another mode,
 `window-number-meta-mode' enables the use of the M- prefix."
   t)
(window-number-mode 1)  ;; always enable mode

;; =================================================================
;; Resize window buffer
(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)
