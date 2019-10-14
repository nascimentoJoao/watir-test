require 'watir';

browser = Watir::Browser.start 'http://localhost:8080'

sizing = true
while sizing
  browser.window.resize_to(684, 768)
  browser.window.move_to(1, 1)
  sizing = false
end


Thread.new {
  browser2 = Watir::Browser.start 'http://localhost:8080'

  sizing = true
  while sizing
    browser2.window.resize_to(684, 768)
    browser2.window.move_to(684 , 1 )
    sizing = false
  end
  
  # enter game
  browser2.a(class: 'btn join').click
  sleep 2
  #### check email e nick
  browser2.input(class: 'email').send_keys('pomp.com')
  sleep 3
  browser2.input(class: 'nick').send_keys('p')
  ###
  sleep 5
  ####  email e nick certo
  ## apaga errado
  browser2.input(class: 'email').to_subtype.clear
  browser2.input(class: 'nick').to_subtype.clear
  sleep 3
  browser2.input(class: 'email').send_keys('pompermaier@mail.com')
  browser2.input(class: 'nick').send_keys('pompermaier_veranopolis')
  #######
  sleep 3
  browser2.input(class: 'id').send_keys :backspace
  browser2.input(class: 'id').send_keys('10032')
  sleep 1
  browser2.a(class: 'btn join').click
}


sleep 12
# create game
browser.a(class: 'btn create').click
sleep 2
#### check email e nick
browser.input(class: 'email').send_keys('pomp.com')
sleep 3
browser.input(class: 'nick').send_keys('p')
######
sleep 4
browser.input(class: 'email').to_subtype.clear
browser.input(class: 'nick').to_subtype.clear
browser.input(class: 'email').send_keys('pompermaier@mail.com')
browser.input(class: 'nick').send_keys('pomper_tester')
sleep 4
browser.input(class: 'categorias').send_keys :backspace
browser.input(class: 'categorias').send_keys '6'
sleep 2
browser.input(class: 'players').send_keys :backspace
browser.input(class: 'players').send_keys '4'
browser.a(class: 'btn create').click
sleep 1

# espera jogador 2 entrar
waiting_player = true
while waiting_player
  lis = browser.lis(class: 'teste')
  liscount = 0 
  lis.each do |li|
    liscount += 1
  end
  if liscount > 1
    waiting_player = false
  end
end

browser.a(class: 'btn init').click

sleep 100
