module AnalyticsHelper

  def get_analytics(location, date)
    poly = RestClient.get("https://nominatim.openstreetmap.org/search.php?q=#{location}&polygon_geojson=1&polygon_threshold=0.003&format=jsonv2")
    poly = JSON.parse(poly)[0]['geojson']['coordinates']

    poly.map! do |poly|
      poly.map do |vert|
        [vert[1], vert[0]]
      end
    end

    poly.map! do |poly|
      earclip_polygon(poly)
    end

    poly.flatten!(1)

    crimes = []
    batch = 0
    poly.each do |tri|
      polygon = tri.map { |vert| "#{vert[0]},#{vert[1]}" }
      begin
        crimes.push(JSON.parse(RestClient.post('https://data.police.uk/api/crimes-street/all-crime', poly: polygon.join(':'), date: date)))
        batch += 1
        if batch == 15
          sleep(0.4)
          batch = 0
        end
      rescue RestClient::BadRequest
        puts 'Bad Polygon'
      end
    end
    crimes.flatten!(1)

    crime_count = {}

    crimes.each do |crime|
      crime_count[crime['category']] = crime_count.key?(crime['category']) ? crime_count[crime['category']] + 1 : 1
    end

    #! Memoize crimes in db instead of sending back to user
    #! Send back poly to user for minimap however
    #TODO Think of more analytics options
    crime_count
  end

  def earclip_polygon(polygon)
    ear_vertex = []
    triangles = []

    polygon = polygon.reverse

    points_count = polygon.length
    points_count.times do |i|
      prev_point = polygon[i - 1]
      point = polygon[i]
      next_index = (i + 1) % points_count
      next_point = polygon[next_index]
      ear_vertex.push(point) if _is_ear(prev_point, point, next_point, polygon)
    end

    while !ear_vertex.empty? && points_count >= 3
      ear = ear_vertex.pop
      i = polygon.index(ear)
      prev_point = polygon[i-1]
      next_index = (i + 1) % points_count
      next_point = polygon[next_index]

      polygon.delete(ear)
      points_count -= 1
      triangles.push([[prev_point[0], prev_point[1]], [ear[0], ear[1]], [next_point[0], next_point[1]]])
      if points_count > 3
        prev_prev_point = polygon[i-2]
        next_next_index = (i + 1) % points_count
        next_next_point = polygon[next_next_index]

        groups = [
          [prev_prev_point, prev_point, next_point, polygon],
          [prev_point, next_point, next_next_point, polygon],
        ]

        groups.each do |group|
          p = group[1]
          if _is_ear(*group)
            ear_vertex.append(p) unless ear_vertex.include? p
          elsif ear_vertex.include? p
            ear_vertex.delete(p)
          end
        end
      end
    end
    triangles
  end

  def _is_ear(p1, p2, p3, polygon)
    _contains_no_points(p1, p2, p3, polygon) and _is_convex(p1, p2, p3) and _triangle_area(p1[0], p1[1], p2[0], p2[1], p3[0], p3[1]).positive?
  end

  def _contains_no_points(p1, p2, p3, polygon)
    polygon.each do |pn|
      if [p1, p2, p3].include? pn
        next
      elsif _is_point_inside(pn, p1, p2, p3)
        return false
      end
    end
    true
  end

  def _is_convex(prev, point, next_point)
    _triangle_sum(prev[0], prev[1], point[0], point[1], next_point[0], next_point[1]).negative?
  end

  def _is_point_inside(p, a, b, c)
    area = _triangle_area(a[0], a[1], b[0], b[1], c[0], c[1])
    area1 = _triangle_area(p[0], p[1], b[0], b[1], c[0], c[1])
    area2 = _triangle_area(p[0], p[1], a[0], a[1], c[0], c[1])
    area3 = _triangle_area(p[0], p[1], a[0], a[1], b[0], b[1])
    (area - [area1, area2, area3].sum).abs < Float::EPSILON
  end

  def _triangle_area(x1, y1, x2, y2, x3, y3)
    ((x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) / 2.0).abs
  end

  def _triangle_sum(x1, y1, x2, y2, x3, y3)
    x1 * (y3 - y2) + x2 * (y1 - y3) + x3 * (y2 - y1)
  end

end