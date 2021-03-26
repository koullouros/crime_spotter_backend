require 'rest-client'
require 'json'



resp1 = RestClient.get('https://nominatim.openstreetmap.org/search.php?q=london&polygon_geojson=1&format=jsonv2')
json = JSON.parse(resp1.body)

poly = json[0]['geojson']['coordinates'][0]

poly2 = []

(0..poly.length).step(100).each do |item|
  poly2.append("#{poly[item][1]}, #{poly[item][0]}")
end

poly2 = poly2.join(':')

puts poly2

date = '2021-01'

# poly2 = '52.268,0.543:52.794,0.238:52.130,0.47'

resp2 = RestClient.post('https://data.police.uk/api/crimes-street/all-crime', poly: poly2, date: date)

puts resp2
