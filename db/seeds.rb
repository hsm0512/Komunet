# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 業務分野の定義
job_categories = [
  { name: "福祉・介護" },
  { name: "子育て・教育" },
  { name: "建設・土木" },
  { name: "環境・ごみ" },
  { name: "防災・危機管理" },
  { name: "健康・医療" },
  { name: "地域振興" },
  { name: "産業・観光" },
  { name: "財務・会計" },
  { name: "人事・労務" },
  { name: "DX・ICT" },
  { name: "住民対応・窓口業務" },
  { name: "企画・政策" },
  { name: "広報・広聴" },
  { name: "選挙管理" },
  { name: "議会対応" },
  { name: "条例・法務" },
  { name: "都市計画・住宅" },
  { name: "税務" },
  { name: "戸籍・住民票" },
  { name: "その他" }
]

job_categories.each do |category|
  JobCategory.find_or_create_by!(name: category[:name])
end

# 投稿スタイルの定義
styles = [
  { name: "質問・相談" },
  { name: "情報共有" },
  { name: "PR・宣伝" },
  { name: "雑談" },
  { name: "その他" }
]

styles.each do |style|
  Style.find_or_create_by!(name: style[:name])
end
