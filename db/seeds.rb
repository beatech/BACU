TwitterAccount.all.each { |ta| ta.destroy }
Circle.all.each { |c| c.destroy }
User.all.each { |u| u.destroy }
Game.all.each { |g| g.destroy }
Master::Music.all.each { |m| m.destroy }

top = Entry.where(id: 1).first
unless top
  Entry.create(
    id: 1,
    title: 'トップページ',
    content: <<-EOS
![banner](http://cdn54.atwikiimg.com/ockac/?plugin=ref&serial=1)

# 概要
音ゲーサークル対抗戦！一番音ゲーの強い大学はどこだ！
１１月４日より開始中！！！！参加サークル募集中です！
2013年もKACが始まりました。せっかくなのでサークル同士でスコアを競ってみよう！
っていう企画です。音ゲーサークルのある大学であればどの大学でも大歓迎です。

2013年11月開始

# 日程
KAC2013予選ラウンドに準拠(2013/10/31 10:00 ～ 2013/11/25 17:59)

そのほか詳しいことに関しては各ページをご覧ください。
    EOS
  )
end

menu = Entry.where(id: 2).first
unless menu
  Entry.create(
    id: 2,
    title: 'メニュー',
    content: <<-EOS
## メニュー
- トップページ
- 概要
- ルール
- 課題曲(注：Googleシート)
- 雑記
- 連絡先

----

## リンク
- KAC公式サイト
- KAC概要(BEMANI wiki)
- 連絡用(Twitter)
    EOS
  )
end

circle_accounts = [
  { screen_name: 'beatech', uid: 519603858, name: 'BEATECH', university: '東京工業大学', url: 'http://beatech.net/' },
  { screen_name: 'beatence', uid: 1308057092, name: 'beatence', university: '東京理科大学', url: 'http://www50.atwiki.jp/beatence/' },
  { screen_name: 'echoes_otg', uid: 550235147, name: 'ECHOES', university: '東京農工大学', url: 'http://www53.atwiki.jp/echoes140/pages/1.html' },
  { screen_name: 'sitmgc', uid: 615024500, name: '芝浦工業大学音ゲーマーの回', university: '芝浦工業大学', url: 'http://www32.atwiki.jp/sit-mgc/' },
  { screen_name: 'EUST_handai', uid: 591930823, name: 'EÜST’', university: '大阪大学', url: 'http://eusthandai.blog.fc2.com/' },
  { screen_name: 'nagoyaotoge', uid: 557766390, name: 'Wuv NU', university: '名古屋大学', url: 'https://sites.google.com/site/nagoyaotoge/home' },
  { name: 'クリスピー', university: '愛知大学', url: 'https://sites.google.com/site/idaiotoge/home' },
]

circle_accounts.each do |circle_account|
  if circle_account[:uid]
    twitter_account = TwitterAccount.create(
      uid: circle_account[:uid],
      screen_name: circle_account[:screen_name]
    )
    Circle.create(
      name: circle_account[:name],
      university: circle_account[:university],
      twitter_account_id: twitter_account.id,
      url: circle_account[:url],
    )
  else
    Circle.create(
      name: circle_account[:name],
      university: circle_account[:university],
      url: circle_account[:url],
    )
  end
end

games = [
  {title: '弐寺', mt1: 'Inferno [SPA]', md1: '☆9', mt2: 'quasar[SPA]', md2: '☆11', gt1: 'SHADE [SPA]', gd1: '☆11', gt2: 'SABER WING [SPA]', gd2: '☆11', gt3: 'blame [SPA]', gd3: '☆11'},
  {title: 'pop\'n', mt1: '秋（autumn G）[H]', md1: 'Lv31', mt2: 'わんわんコア（ポチコの幸せな日常）[EX]', md2: 'Lv45', gt1: 'ハイスピード幻想チューン/SHION', gd1: 'Lv45', gt2: 'メカニカルジャズ/Apple Butter', gd2: 'Lv45', gt3: 'ポップミュージック/うた', gd3: 'Lv47'},
  {title: '指', mt1: 'LANA - キロクノカケラ (sasakure.UK Framework Remix) -[EXT]', md1: 'Lv8', mt2: 'Stand Alone Beat Masta [EXT]', md2: 'Lv10', gt1: 'We\'re so Happy[EXT]', gd1: 'Lv10', gt2: '†渚の小悪魔ラヴリィ～レイディオ†[EXT]', gd2: 'Lv10', gt3: 'Our Faith[EXT]', gd3: 'Lv10'},
  {title: 'REFLEC', mt1: 'つばめ[H]', md1: 'Lv8', mt2: 'Windy Fairy[H]', md2: 'Lv10', gt1: '7 Colors', gd1: 'Lv9', gt2: 'exmination leave', gd2: 'Lv10', gt3: 'Playing With Fire', gd3: 'Lv10+'},
  {title: 'DDR', mt1: 'Condor[DIF]', md1: '足9', mt2: 'Another Phase[EXP]', md2: '足15', gt1: 'CHAOS(鬼)', gd1: '足16', gt2: 'GAIA(激)', gd2: '足16', gt3: 'tokyoEVOLVED (TYPE1)（激）', gd3: '足16'},
  {title: 'GF', mt1: 'しっぽのロック[EXP-B]', md1: '5.25', mt2: 'Jasper[EXT-G]', md2: '7.55', gt1: 'Mighty Wind', gd1: '7.60', gt2: 'キケンな果実', gd2: '7.70', gt3: '虹色の花', gd3: '7.70'},
  {title: 'DM', mt1: 'Chronos[ADV]', md1: '5.25', mt2: '三毛猫ロックンロール[EXT]', md2: '8.00', gt1: 'TRICK[EXP]', gd1: '7.00', gt2: 'solitude[EXP]', gd2: '7.75', gt3: '8 -eight- [EXP]', gd3: '8.10'},
  {title: 'SDVX', mt1: 'candii[EXH]', md1: 'Lv11', mt2: 'GEROL[EXH]', md2: 'Lv14', gt1: 'BUBBLE RAVER[EXH]', gd1: 'Lv14', gt2: '- dirty rouge - [EXH]', gd2: 'Lv14', gt3: 'Venona[EXH]', gd3: 'Lv14'},
  {title: 'ダンエボ', mt1: 'なめこのうた[MASTER]', md1: 'Lv1', mt2: 'サイバーサンダーサイダー[MASTER]', md2: 'Lv3', gt1: 'Do the Evolution', gd1: '?', gt2: '行くぜっ！怪盗少女 -Zver.-', gd2: '?', gt3: 'CAN\'T STOP FALLIN\' IN LOVE -super euro version-', gd3: '?'},
]

games.each do |game|
  g = Game.create(title: game[:title])
  Master::Music.create(title: game[:mt1], difficulty: game[:md1], game_id: g.id)
  Master::Music.create(title: game[:mt2], difficulty: game[:md2], game_id: g.id)
  Game::Music.create(title: game[:gt1], difficulty: game[:gd1], game_id: g.id)
  Game::Music.create(title: game[:gt2], difficulty: game[:gd2], game_id: g.id)
  Game::Music.create(title: game[:gt3], difficulty: game[:gd3], game_id: g.id)
end
