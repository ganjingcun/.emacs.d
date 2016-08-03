;; 关闭工具栏
(tool-bar-mode -1)
;; 关闭滚动条
(scroll-bar-mode -1)

;; 关闭启动画面
(setq inhibit-splash-screen t)
;; 设置全局光标样式
;; (setq cursor-type 'bar)
(setq-default cursor-type 'bar)

;;高亮当前行
(global-hl-line-mode t)

;; 打开时全屏
;;(setq initial-frame-alist (quote ((fullscreen . maximized))))

(provide 'init-ui)
