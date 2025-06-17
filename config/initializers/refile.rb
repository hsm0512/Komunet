Refile.secret_key = 'db998f90366e9f2fe7dc3f48c707fbb5c77ff63172319510e731d57ee329f08f7dfa92774af33f1466683e4997c5d656d4ab07adda56f83e8a69bcdd1570493b'

# 本番環境のみRefile.hostを指定
if Rails.env.production?
  Refile.host = 'https://komunet.onrender.com'
end