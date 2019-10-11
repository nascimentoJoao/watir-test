require 'watir';

browser = Watir::Browser.start 'http://localhost:8080'

# create game
browser.a(class: 'btn create').click
sleep 4
browser.input(class: 'email').send_keys('pompermaier@mail.com')
sleep 4
browser.input(class: 'nick').send_keys('pomper_veranopolis')
sleep 4
browser.input(class: 'categorias').send_keys :backspace
browser.input(class: 'categorias').send_keys '6'
sleep 4
browser.input(class: 'players').send_keys :backspace
browser.input(class: 'players').send_keys '4'

# back to homepage
browser.a(class: 'btn back').click

# enter game
browser.a(class: 'btn join').click
sleep 4
browser.input(class: 'email').send_keys('pompermaier@mail.com')
sleep 4
browser.input(class: 'nick').send_keys('pomper_veranopolis')
sleep 4
browser.input(class: 'id').send_keys('9854653')

#browser.input(type: 'email').send_keys('joao@mail.com')
#for i in (0..40).step(5)
#    browser.driver.execute_script("window.scrollBy(0,#{i})")
#    sleep 0.1
#end
#browser.div(jsname: 'W85ice').send_keys('PUCRS')
# input > find by name
sleep 3
