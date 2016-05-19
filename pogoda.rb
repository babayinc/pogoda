if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require 'net/http'
require 'uri'
require 'rexml/document'

# http://informer.gismeteo.ua/xml/33345_1.xml

uri = URI.parse("http://informer.gismeteo.ua/xml/33345_1.xml")

response = Net::HTTP.get_response(uri)

doc = REXML::Document.new(response.body)

city_name = doc.elements['MMWEATHER/REPORT/TOWN'].attributes['sname']

time = Time.now

temperature = doc.elements['MMWEATHER/REPORT/TOWN/FORECAST/TEMPERATURE'].to_s

#pogoda
#wind

puts "Now #{time}, weather in #{city_name}"
puts "#{temperature}"