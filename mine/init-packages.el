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
	       ;;mac中将当前文件在finder中打开的插件
	       reveal-in-osx-finder
	       web-mode
	       js2-refactor
	       expand-region
	       iedit
	       paredit
	       paren-face
	       helm-ag
	       flycheck
	       auto-yasnippet
	       evil-leader
	       window-numbering
	       which-key
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
;; 在emact-lisp模式下  输入单引号 不主动生成
(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
(sp-local-pair 'lisp-interaction-mode "'" nil :actions nil)

;; 也可以把上面两句合起来
;;(sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil)


;; 智能搜索
(ivy-mode t)
(setq ivy-use-virtual-buffers t)

;; config mode for js files
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       '(("\\.html\\'" . web-mode))
       '(("\\.htm\\'" . web-mode))
       auto-mode-alist))

;; 全局自动补全
(global-company-mode t)

;; monokai 主题
(load-theme 'monokai t)

;; 搜索时候 按q 跳转回来 极为方便
(require 'popwin)
(popwin-mode t)


(defun my-web-mode-indent-setup ()
  (setq web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 2)    ; web-mode, css in html file
  (setq web-mode-code-indent-offset 2)   ; web-mode, js code in html file
  )
(add-hook 'web-mode-hook 'my-web-mode-indent-setup)


;;下面的函数可以用于在两个空格和四个空格之间进行切换
(defun my-toggle-web-indent ()
  (interactive)
  ;; web development
  (if (or (eq major-mode 'js-mode) (eq major-mode 'js2-mode))
      (progn
	(setq js-indent-level (if (= js-indent-level 2) 4 2))
	(setq js2-basic-offset (if (= js2-basic-offset 2) 4 2))))

  (if (eq major-mode 'web-mode)
      (progn (setq web-mode-markup-indent-offset (if (= web-mode-markup-indent-offset 2) 4 2))
	     (setq web-mode-css-indent-offset (if (= web-mode-css-indent-offset 2) 4 2))
	     (setq web-mode-code-indent-offset (if (= web-mode-code-indent-offset 2) 4 2))))
  (if (eq major-mode 'css-mode)
      (setq css-indent-offset (if (= css-indent-offset 2) 4 2)))

  (setq indent-tabs-mode nil))

(global-set-key (kbd "C-c t i") 'my-toggle-web-indent)


;; js 的 重构工具
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-m")

;; 绑定 imenu
(global-key-binding (kbd "M-s i") 'counsel-imenu)

;;expand-region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; 给iedit 模式绑定快捷键
(require 'iedit)
(global-key-binding (kbd "M-s e") 'iedit-mode)

;; schemo paredit mode
(autoload 'paredit-mode "paredit" "Minor mode for pseudo-structurally editing Lisp code." t)


;; 让括号不那么显眼
;;(require 'paren-face)
;;(set-face-foreground 'paren-face "DimGray")
(global-paren-face-mode t)

;;flycheck
;;(global-flycheck-mode t)
(add-hook 'js2-mode-hook #'flycheck-mode)

;; 自动代码补全
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

;; 自动代码补全
(global-set-key (kbd "H-w") #'aya-create)
(global-set-key (kbd "H-y") #'aya-expand)




;; vim 相关配置 

(evil-mode t)
(setcdr evil-insert-state-map nil)
(define-key evil-insert-state-map [escape] 'evil-normal-state)

(global-evil-leader-mode t)
(evil-leader/set-key
  "ff" 'find-file                 ;; find file 
  "rf" 'recentf-open-files        ;; recnet file list 
  "pf" 'counsel-git               ;; project files
  "fs" 'helm-ag                   ;; file search 
  "w3" 'split-window-right
  "w2" 'split-window-below
  "w1" 'delete-other-windows)

;; M-0～9切换窗口 （原来的需要按 C-x o 或者evil模式下按C-w h C-w l 使用上不方便）
(window-numbering-mode t)

(which-key-mode t)
;;(which-key-setup-side-window-right)

(provide 'init-packages)
