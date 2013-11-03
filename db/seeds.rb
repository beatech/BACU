TwitterAccount.all.each { |ta| ta.destroy }
Circle.all.each { |c| c.destroy }

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
