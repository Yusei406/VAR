# 必要なパッケージをインストールしてロード
install.packages("vars")
library(vars)

# Canadaデータセットをロード
data("Canada")

# データセットの概要を表示
summary(Canada)
head(Canada)

# ラグの長さの選択
lag_selection <- VARselect(Canada, lag.max = 10, type = "const")
best_lag <- lag_selection$selection["AIC(n)"]

# VARモデルの作成
var_model <- VAR(Canada, p = best_lag, type = "const")

# モデルの概要を表示
summary(var_model)

# インパルス応答関数の計算（eのショックに対する他の変数の影響）
irf_result <- irf(var_model, impulse = "e", response = c("prod", "rw", "U"), n.ahead = 10, boot = TRUE)

# 結果をプロット
plot(irf_result)

# フォーキャストエラーバリアンスデコンポジションの計算
fevd_result <- fevd(var_model, n.ahead = 10)

# 結果をプロット
plot(fevd_result)

# グレンジャー因果性の検定
causality(var_model, cause = "e")

