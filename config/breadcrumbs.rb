crumb :root do
  link "報告会一覧", root_path
end

crumb :main do |main|
  link "報告会詳細", main_path(main)
  parent :root
end

crumb :main_field do |main|
  link 'フィールド', field_main_path(main)
  parent :main, main
end

crumb :main_human do |main|
  link 'ヒューマン', human_main_path(main)
  parent :main, main
end

crumb :main_data do |main|
  link 'データ', data_main_path(main)
  parent :main, main
end

crumb :main_life do |main|
  link 'ライフ', life_main_path(main)
  parent :main, main
end

crumb :main_manage do |main|
  link 'マネジ', manage_main_path(main)
  parent :main, main
end

crumb :present do |present|
  link 'アンケート', present_path(present)

  if present.research == 'フィールドサイエンス'
    parent :main_field, present.main
  elsif present.research == 'ヒューマンサイエンス'
    parent :main_human, present.main
  elsif present.research == 'データサイエンス'
    parent :main_data, present.main
  elsif present.research == 'ライフスタイル'
    parent :main_life, present.main
  else present.research == 'マネジメント'
    parent :main_manage, present.main
  end
end

crumb :present_owner do |present|
  link 'アンケート集計', owner_present_path(present)
  parent :present, present
end
