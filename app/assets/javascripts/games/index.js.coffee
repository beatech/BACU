jQuery ($)->
  GAME_NUM = 9
  game_id = 1
  while (game_id < 2)
    $.post('/games/' + game_id + '/score_ranking')
    game_id += 1
