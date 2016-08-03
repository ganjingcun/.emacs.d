;; cl - Common Lisp Extension
(require 'cl)

(when (>= emacs-major-version 24)
    (require 'package)
    (setq package-archives '(("gnu"   . "http://elpa.zilongshanren.com/gnu/")
                         ("melpa" . "http://elpa.zilongshanren.com/melpa/")))
    ;;(add-to-list 'package-archives '("melpa" . "http://elpa.zilongshanren.com/melpa/") t)
    )

;; Add Packages
(defvar my/packages '(
	       company
	       hungry-delete
	       swiper
	       counsel
	       smartparens
	       monokai-theme
	       js2-mode
	       nodejs-repl
	       ;;mac 系统  －－为了找到可执行程序
	       exec-path-from-shell
	       popwin
	       ) "Default packages")

(setq package-selected-packages my/packages)

(defun my/packages-installed-p ()
    (loop for pkg in my/packages
	  when (not (package-installed-p pkg)) do (return nil)
	  finally (return t)))

(unless (my/packages-installed-p)
    (message "Refreshing package database...")
    (package-refresh-contents)
    (dolist (pkg my/packages)
      (when (not (package-installed-p pkg))
	(package-install pkg))))

;; Find Executable Path on OS X
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))


;; 一次性 删除多个空格
(require 'hungry-delete)
(global-hungry-delete-mode)

;; 括号匹配
;;(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(smartparens-global-mode t)

;; 智能搜索
(ivy-mode t)
(setq ivy-use-virtual-buffers t)

;; config mode for js files
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))

;; 全局自动补全
(global-company-mode t)

;; monokai 主题
(load-theme 'monokai t)

;; 搜索时候 按q 跳转回来 极为方便
(require 'popwin)
(popwin-mode t)


(provide 'init-packages)
