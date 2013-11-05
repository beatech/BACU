jQuery ($)->
  GAME_NUM = 9
  game_id = 1
  while (game_id <= GAME_NUM)
    $.post('/games/' + game_id + '/score_ranking')
    game_id += 1
