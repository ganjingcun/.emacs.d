(package-initialize)

(add-to-list 'load-path "~/.emacs.d/mine/")

;; 打开本配置文件
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(require 'init-packages)
(require 'init-ui)
(require 'init-better-defaults)
(require 'init-org)
(require 'init-keybindings)


;; 加载custom.el 作为指定的customeize文件
(setq custom-file (expand-file-name "mine/custom.el" user-emacs-directory))

(load-file custom-file)


























