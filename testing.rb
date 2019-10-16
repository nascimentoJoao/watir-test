require 'watir';

browser = Watir::Browser.start 'http://localhost:8080'

open('StopCidadaniaLogTest.csv', 'a') { |f|
  f.puts "InputTest,InputValue,Error,Section,Commentary"
}

open('StopCidadaniaLogTest.csv', 'a') { |f|
  f.puts "FirstAction, tela criada com sucesso,-,-,iniciando fluxo de testes"
}

criar_jogo = Thread.new {
  sizing = true
  while sizing
    browser.window.resize_to(684, 768)
    browser.window.move_to(1, 1)
    sizing = false
  end
  # create game
  browser.a(class: 'btn create').click
  sleep 2
  #### check email e nick
  variable = browser.input(class: 'email').send_keys('pomp.com')

  sleep 3
  browser.input(class: 'nick').send_keys('p')

  invalid_msg_create_game = browser.p(class: 'invalidEmailMsg').text

  if invalid_msg_create_game == 'Email inválido'
    open('StopCidadaniaLogTest.csv', 'a') { |f|
      f.puts "Email,pomp.com,Email inválido,Criação de sala"
    }
    puts "Teste com email inválido passou. Na criação da sala de jogo"
  end

  invalid_nick_msg_create_game = browser.p(class: 'invalidNickMsg').text

  if invalid_nick_msg_create_game != 'Apelido inválido'
    open('StopCidadaniaLogTest.csv', 'a') { |f|
      f.puts "Nickname,p,Apelido inválido,Criação de sala"
    }
    puts "Teste com nick inválido passou. Na criação da sala de jogo"
  end

  ######
  sleep 4
  browser.input(class: 'email').to_subtype.clear
  browser.input(class: 'nick').to_subtype.clear
  browser.input(class: 'email').send_keys('pompermaier@mail.com')
  sleep 3
  browser.input(class: 'nick').send_keys('pomper_tester')
  invalid_msg_create_game = browser.p(class: 'invalidEmailMsg').text

  if invalid_msg_create_game != 'Email inválido'
    open('StopCidadaniaLogTest.csv', 'a') { |f|
      f.puts "Email,pompermaier@mail.com,Email válido,Criação de sala"
    }
    puts "Teste com email válido passou. Na criação da sala de jogo"
  end

  invalid_nick_msg_create_game = browser.p(class: 'invalidNickMsg').text


  if invalid_nick_msg_create_game == 'Apelido inválido'
    open('StopCidadaniaLogTest.csv', 'a') { |f|
      f.puts "Nickname,pomper_tester,Apelido válido,Criação de sala"
    }
    puts "Teste com nick válido passou. Na criação da sala de jogo"
  end

  sleep 4
  browser.input(class: 'categorias').send_keys :backspace
  browser.input(class: 'categorias').send_keys '6'
  sleep 2
  browser.input(class: 'players').send_keys :backspace
  browser.input(class: 'players').send_keys '4'
  browser.a(class: 'btn create').click
  sleep 1

}

criar_jogo.join

browser2 = Watir::Browser.start 'http://localhost:8080'

entrar_jogo = Thread.new {
  sizing = true
  while sizing
    browser2.window.resize_to(684, 768)
    browser2.window.move_to(684 , 1)
    sizing = false
  end
  
  # enter game
  browser2.a(class: 'btn join').click
  sleep 2
  #### check email e nick
  browser2.input(class: 'email').send_keys('pomp.com')
  sleep 3
  browser2.input(class: 'nick').send_keys('p')

  invalid_email_msg_join_game = browser2.p(class: 'invalidEmailMsg').text

  if invalid_email_msg_join_game == 'Email inválido'

    open('StopCidadaniaLogTest.csv', 'a') { |f|
      f.puts "Email,pomp.com,Email inválido,Entrar no jogo"
    }

    puts "Teste com email inválido passou. Entrar na sala de jogo"
  end

  invalid_nick_msg_join_game = browser2.p(class: 'invalidNickMsg').text

  if invalid_nick_msg_join_game != 'Apelido inválido'

    open('StopCidadaniaLogTest.csv', 'a') { |f|
      f.puts "Nickname,p,Apelido inválido,Entrar no jogo"
    }

    puts "Teste com nick inválido passou. Entrar na sala de jogo"
  end

  ###
  sleep 5
  ####  email e nick certo
  ## apaga errado
  browser2.input(class: 'email').to_subtype.clear
  browser2.input(class: 'nick').to_subtype.clear
  sleep 3
  browser2.input(class: 'email').send_keys('pompermaier@mail.com')
  sleep 3
  browser2.input(class: 'nick').send_keys('pompermaier_veranopolis')

  invalid_email_msg_join_game = browser2.p(class: 'invalidEmailMsg').text

  if invalid_email_msg_join_game != 'Email inválido'
    open('StopCidadaniaLogTest.csv', 'a') { |f|
      f.puts "Email,pompermaier@mail.com,Email válido,Entrar no jogo"
    }

    puts "Teste com email válido passou. Entrar na sala de jogo"

  end

  invalid_nick_msg_join_game = browser2.p(class: 'invalidNickMsg').text

  if invalid_nick_msg_join_game == 'Apelido inválido'
    puts "Teste com nick válido passou. Entrar na sala de jogo"
  end

  #######
  sleep 3
  browser2.input(class: 'id').send_keys :backspace
  browser2.input(class: 'id').send_keys('10041')
  sleep 1
  browser2.a(class: 'btn join').click
}

entrar_jogo.join

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
