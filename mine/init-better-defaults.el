;; 不要发出警告声
;;(setq ring-bell-function 'ignore)


;; 自动加载外部的变动
(global-auto-revert-mode t)

;; 显示行号
(global-linum-mode t)



;; 设置自动补全规则
(abbrev-mode t)

(define-abbrev-table 'global-abbrev-table '(
					    ;; signature
					    ("8jc" "ganjingcun")
					    ;; emacs regexp
					    ("8ms" "Microsoft")
					    ))









;; 去掉~后缀备份文件
(setq make-backup-files nil)
(setq auto-save-default nil)


;; 设置最近打开文件 以及其参数
(recentf-mode 1)
(setq recentf-max-menu-items 15)

;; 在选择的部分输入 会删除掉已选择的文本
(delete-selection-mode t)

;; 光标在括号内的时候  就高亮左右的括号
(defadvice show-paren-function (around fix-show-paren-function activate)
  (cond ((looking-at-p "\\s(") ad-do-it)
	(t (save-excursion
	     (ignore-errors (backward-up-list))
	     ad-do-it))))

;; show match parents
(add-hook 'emacs-lisp-mode-hook  'show-paren-mode)

(defun indent-buffer()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer()
  (interactive)
  (save-excursion
    (if (region-active-p)
	(progn
	  (indent-region (region-beginning) (region-end))
	  (message "Indent selected region."))
      (progn
	(indent-buffer)
	(message "Indent buffer.")))))




;; 另一种补全
(setq hippie-expand-try-function-list '(try-expand-debbrev
					try-expand-debbrev-all-buffers
					try-expand-debbrev-from-kill
					try-complete-file-name-partially
					try-complete-file-name
					try-expand-all-abbrevs
					try-expand-list
					try-expand-line
					try-complete-lisp-symbol-partially
					try-complete-lisp-symbol))




;;删除目录的时候 Emacs 会询问是否递归删除或拷贝，
(fset 'yes-or-no-p 'y-or-n-p)
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)
;; 重用dired buffer 避免创建很多无用buffer
(put 'dired-find-alternate-file 'disabled nil)

;; 主动加载 Dired Mode
;;(require 'dired)
;;(defined-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)

;; 延迟加载
(with-eval-after-load 'dired
    (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

;; dired-x 允许 c-x c-j 直接打开当前文件所在的文件夹
(require 'dired-x)

;;方便两个文件夹之间的复制行为
(setq dired-dwim-target t)

;; 隐藏dos下的换行符
(defun hidden-dos-eol ()
  ;;"Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (unless buffer-display-table
    (setq buffer-display-table (make-display-table)))
  (aset buffer-display-table ?\^M []))

;; 删除dos下的换行符
(defun remove-dos-eol ()
  ;;"Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

;;"Call `occur' with a sane default."
(defun occur-dwim ()
  (interactive)
  (push (if (region-active-p)
	    (buffer-substring-no-properties
	     (region-beginning)
	     (region-end))
	  (let ((sym (thing-at-point 'symbol)))
	    (when (stringp sym)
	      (regexp-quote sym))))
	regexp-history)
  (call-interactively 'occur))
(global-set-key (kbd "M-s o") 'occur-dwim)


;;imenu  列出函数

;;;;;;;;;;;;
;; Scheme 
;;;;;;;;;;;;

(require 'cmuscheme)
(setq scheme-program-name "petite")         ;; 如果用 Petite 就改成 "petite"


;; bypass the interactive question and start the default interpreter
(defun scheme-proc ()
  "Return the current Scheme process, starting one if necessary."
  (unless (and scheme-buffer
               (get-buffer scheme-buffer)
               (comint-check-proc scheme-buffer))
    (save-window-excursion
      (run-scheme scheme-program-name)))
  (or (scheme-get-process)
      (error "No current process. See variable `scheme-buffer'")))


(defun scheme-split-window ()
  (cond
   ((= 1 (count-windows))
    (delete-other-windows)
    (split-window-vertically (floor (* 0.68 (window-height))))
    (other-window 1)
    (switch-to-buffer "*scheme*")
    (other-window 1))
   ((not (find "*scheme*"
               (mapcar (lambda (w) (buffer-name (window-buffer w)))
                       (window-list))
               :test 'equal))
    (other-window 1)
    (switch-to-buffer "*scheme*")
    (other-window -1))))


(defun scheme-send-last-sexp-split-window ()
  (interactive)
  (scheme-split-window)
  (scheme-send-last-sexp))


(defun scheme-send-definition-split-window ()
  (interactive)
  (scheme-split-window)
  (scheme-send-definition))

(add-hook 'scheme-mode-hook
  (lambda ()
    (paredit-mode 1)
    (define-key scheme-mode-map (kbd "<f7>") 'scheme-send-last-sexp-split-window)
    (define-key scheme-mode-map (kbd "<f6>") 'scheme-send-definition-split-window)))

;; 默认字符集
(set-language-environment "UTF-8")

(provide 'init-better-defaults)


