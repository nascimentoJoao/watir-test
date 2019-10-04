require 'watir';
browser = Watir::Browser.start 'https://docs.google.com/forms/d/e/1FAIpQLSdZaaC5z-39_b0gi1kjX4GvBeWgybs2HfIyPxCe52hcZtznNQ/viewform?usp=sf_link'
browser.input(jsname: 'YPqjbf').send_keys('Joao Nascimento')
browser.input(type: 'email').send_keys('joao@mail.com')
for i in (0..1000).step(5)
    browser.driver.execute_script("window.scrollBy(0,#{i})")
    sleep 0.1
end

sleep 5