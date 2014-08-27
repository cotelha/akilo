#!/usr/bin/ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http'

uri = URI('http://www.visate.com.br/2012/includes/get_trajetos.php')
res = Net::HTTP.post_form(uri, 'id_itinerario'=>'0', 'user'=>'37', 'id_linha'=>'44', 'data'=>Time.now.strftime('%d/%m/%Y'), 'id_horario'=>'5')
# res.body
page = Nokogiri::HTML(res.body)

page.css('tr').each do |line|
  ln = line.css('td')
  puts "#{ln[0].text} - #{ln[1].text} - #{ln[2].text}"
end

uri = URI('http://www.visate.com.br/2012/index.php')
res = Net::HTTP.get(uri)
page = Nokogiri::HTML(res)
page.css("select[id='linha']").css("option").each do |option|
  puts "#{option['value']} - #{option.text}"
end

# necessário guardar a data da última atualização de horários
# loop para guardar os HORARIOS disponiveis POR (LINHA e FAIXA DE HORÁRIO NA DATA ATUAL), lembrando que existe diferenca de horarios nos (feriados e finais de semana)
# na APP ou interface jah pode selecionar a data ATUAL e a FAIXA do HORARIO para a pessoa, facilitando o acesso!
# Update: Command Line interator : http://ruby-doc.org/stdlib-2.1.2/libdoc/optparse/rdoc/OptionParser.html

# em flash com o trajeto
# http://www.visate.com.br/2012/swf/viaggia_v07.swf?user=37&linha=0&periodo=20140521&horario=5&itinerario=0&hora=
# em flash com horarios
# http://www.visate.com.br/2012/home.php?link=Portal%20do%20Usu%C3%A1rio&sublink=Linhas%20e%20Hor%C3%A1rios

# VALORES PARA AS BUSCAS
# Itinerarios
# "0" > Todos os Itinerários
# Faixa Horária
# "5" > Todos os Horários
# "1" > Das 05:00 às 12:00
# "2" > Das 12:00 às 18:00
# "3" > Das 18:00 às 24:00
# "4" > Das 24:00 às 05:00

=begin
curl '' -X POST -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-US,en;q=0.5' -H 'Connection: keep-alive' -H 'Cookie: _ga=GA1.3.1759108421.1400713183' -H 'Host: www.visate.com.br' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:29.0) Gecko/20100101 Firefox/29.0' -H 'Content-Type: application/x-www-form-urlencoded'

http://www.visate.com.br/2012/ge/trajeto_web.php
itinerario=71004&user=37

curl '' -X POST -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-US,en;q=0.5' -H 'Connection: keep-alive' -H 'Cookie: _ga=GA1.3.1759108421.1400713183' -H 'Host: www.visate.com.br' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:29.0) Gecko/20100101 Firefox/29.0' -H 'Content-Type: application/x-www-form-urlencoded'

http://www.visate.com.br/2012/ge/horarios_web.php
horario=3&itinerario=0&linha=71&periodo=20140521&user=37

curl '' -X POST -H 'Host: www.visate.com.br' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:29.0) Gecko/20100101 Firefox/29.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' -H 'Accept-Encoding: gzip, deflate' -H 'Cookie: _ga=GA1.3.1759108421.1400713183' -H 'Connection: keep-alive' -H 'Content-Type: application/x-www-form-urlencoded'

http://www.visate.com.br/2012/ge/linhas_web.php
user=37

curl '' -H 'Accept: text/html, */*' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-US,en;q=0.5' -H 'Cache-Control: no-cache' -H 'Connection: keep-alive' -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' -H 'Cookie: _ga=GA1.3.1759108421.1400713183' -H 'Host: www.visate.com.br' -H 'Pragma: no-cache' -H 'Referer: http://www.visate.com.br/2012/index.php' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:29.0) Gecko/20100101 Firefox/29.0' -H 'X-Requested-With: XMLHttpRequest' --data 'id_linha=71&user=37'

http://www.visate.com.br/2012/includes/get_itinerarios.php
id_linha=71&user=37


Uso:
http://www.visate.com.br/2012/ge/linhas_web.php

Params:
user=37

Options:
Content-Type
application/x-www-form-urlencoded
=end
