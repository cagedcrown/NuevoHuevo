json.array!(@schemes) do |scheme|
  json.extract! scheme, :id, :font1, :font2, :color1, :color2, :color3, :color4, :color5
  json.url scheme_url(scheme, format: :json)
end
