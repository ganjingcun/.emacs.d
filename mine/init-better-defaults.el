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

;; show match parents
(add-hook 'emacs-lisp-mode-hook  'show-paren-mode)

(provide 'init-better-defaults)
