(when (>= emacs-major-version 24)
    (require 'package)
    (package-initialize)

    (add-to-list 'package-archives '("melpa" . "http://elpa.zilongshanren.com/melpa/") t))



;; cl - Common Lisp Extension
(require 'cl)

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










;; 关闭工具栏
(tool-bar-mode -1)
;; 关闭滚动条
(scroll-bar-mode -1)
;; 显示行号
(global-linum-mode t)
;; 关闭启动画面
(setq inhibit-splash-screen t)




;; 打开本配置文件
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "<f5>") 'open-my-init-file)

;; 全局自动补全
(global-company-mode t)


;; 设置全局光标样式
;; (setq cursor-type 'bar)
(setq-default cursor-type 'bar)

;; 去掉~后缀备份文件
(setq make-backup-files nil)

;; 文档语法高亮
(require 'org)
(setq org-src-fontify-natively t)

;; 设置最近打开文件 以及其参数
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 15)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; 在选择的部分输入 会删除掉已选择的文本
(delete-selection-mode t)


;; 打开时全屏
;;(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; show match parents

(add-hook 'emacs-lisp-mode-hook  'show-paren-mode)


;;高亮当前行
(global-hl-line-mode t)


(load-theme 'monokai 1)

(require 'hungry-delete)
(global-hungry-delete-mode)


(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-load-library)



(require 'smartparens-config)
;;(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(smartparens-global-mode t)


;; confi mode for js files
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))


(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

(setq org-agenda-files '("~/myorg"))
(global-set-key (kbd "C-c a") 'org-agenda)


;; -------------   customeize -------------- ;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 0.08))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
