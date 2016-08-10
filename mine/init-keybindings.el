;; swiper 
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-load-library)

;; recent files
(global-set-key (kbd "C-x C-r") 'recentf-open-files)
;;(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; help 
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

;; init file
(global-set-key (kbd "<f5>") 'open-my-init-file)

;; 搜索被git管理的文件
(global-set-key (kbd "C-c p f") 'counsel-git)

;; 自动缩进
(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)

;; 另一种补全
(global-set-key (kbd "s-/") 'hippie-expand)

;; 在finder中打开
(global-set-key (kbd "C-,") 'reveal-in-osx-finder)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))


(global-set-key (kbd "C-c p s") 'helm-ag-project-root)

(provide 'init-keybindings)

