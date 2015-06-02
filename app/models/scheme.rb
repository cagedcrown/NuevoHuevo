class Scheme < ActiveRecord::Base
  attr_accessor :project_type, :palette_type, :base_color
  before_create :generate

  validates_presence_of :project_type, :palette_type, :base_color
  has_many :users

  def generate
    generate_base_hue(base_color)
    populate_fonts(project_type)
    populate_colors(palette_type)
  end


  def populate_colors(palette_type)
    case palette_type
    when "Monochromatic"
      self.color1, self.color2, self.color3, self.color4, self.color5 = generate_monochromatic_scheme(generate_base_hue(base_color))
    when "Complimentary"
      self.color1, self.color2, self.color3, self.color4, self.color5 = generate_complimentary_scheme(generate_base_hue(base_color))
    when "Analogous"
      self.color1, self.color2, self.color3, self.color4, self.color5 = generate_analogous_scheme(generate_base_hue(base_color))
    end
  end

  def populate_fonts(project_type)
    self.font1, self.font2 = generate_font_combo(project_type)
  end

  def generate_font_combo(project_type)
    case project_type
    when "Journalism"
      return [random_font(humanist_serif), random_font(humanist_sans) ] # index 0 will be header, 1 will be body
    when "History"
      return [random_font(humanist_serif), random_font(humanist_sans) ]
    when "Academia"
      return [random_font(transitional_serif), random_font(transitional_sans) ]
    when "Legal"
      return [random_font(transitional_serif), random_font(transitional_sans) ]
    when "Arts + Culture"
      return [ random_font(modern_serif), random_font(humanist_sans) ]
    when "Marketing"
      return [ random_font(modern_serif), random_font(humanist_sans) ]
    when "Promotional"
      return [ random_font(modern_serif), random_font(humanist_sans) ]
    when "Government"
      return [random_font(humanist_sans), random_font(humanist_serif) ]
    when "Education"
      return [random_font(humanist_sans), random_font(humanist_serif) ]
    when "Finance"
      return [random_font(humanist_sans), random_font(humanist_serif) ]
    when "Technology"
      return [random_font(transitional_sans), random_font(transitional_serif)]
    when "Transportation"
      return [random_font(transitional_sans), random_font(transitional_serif)]
    when "Science"
      return [random_font(geometric_sans), random_font(transitional_serif)]
    when "Architecture"
      return [random_font(geometric_sans), random_font(transitional_serif)]
    end
  end

  def generate_base_hue(base_color)
    case base_color
    when "Red"
      return (1..10).to_a.sample
    when "Orange"
      return (20..30).to_a.sample
    when "Yellow"
      return (46..60).to_a.sample
    when "Green"
      return (80..140).to_a.sample
    when "Blue"
      return (175..250).to_a.sample
    when "Purple"
      return (262..277).to_a.sample
    when "Pink"
      return (290..335).to_a.sample
    end
  end

  def generate_monochromatic_scheme(base_hue)
    [ "#{base_hue}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%", "#{base_hue}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%","#{base_hue}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%","#{base_hue}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%","#{base_hue}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%"]
  end

  def generate_complimentary_scheme(base_hue)
    if base_hue + 180 <= 360
      ["#{base_hue + [0,180].sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{base_hue + [0,180].sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{base_hue + [0,180].sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{base_hue + [0,180].sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{base_hue + [0,180].sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%"]
    else
      [ "#{base_hue - [0,180].sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{base_hue - [0,180].sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{base_hue - [0,180].sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{base_hue - [0,180].sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{base_hue - [0,180].sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%"]
    end
  end

  def generate_analogous_scheme(base_hue)
    if base_hue + 40 <= 360 && base_hue - 40 >= 0
      [ "#{base_hue + (-40..40).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%", "#{base_hue + (-40..40).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%", "#{base_hue + (-40..40).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%", "#{base_hue + (-40..40).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%", "#{base_hue + (-40..40).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%"]
    elsif base_hue - 40 < 0
      [ "#{(0..40).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{(0..40).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{(0..40).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{(0..40).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{(0..40).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" ]
    elsif base_hue + 40 > 360
      [ "#{(320..360).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{(320..360).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{(320..360).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{(320..360).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{(320..360).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" ]
    end
  end

  def fonts
    [font1, font2]
  end

  # the scheme's fonts that are google fonts
  def needed_google_fonts
    fonts & google_fonts
  end

  def google_fonts
    (font_wish_list - troublesome_fonts - reserved_fonts).sort
  end

  def font_wish_list
    egyptian_serif + geometric_sans + humanist_sans + humanist_serif + modern_serif + transitional_serif + transitional_sans
  end

  def reserved_fonts
    "Gill+Sans|Helvetica|Didot|Garamond|Palatino|Rockwell|Trebuchet".split("|")
  end

  def troublesome_fonts
    "Rockwell|Verdana|Trebuchet+MS|Bodoni".split("|")
  end

  def random_font(fonts)
    fonts.sample
  end

  def egyptian_serif
    ["Arvo", "Bitter", "Coustard", "Patua One", "Rockwell", "Josefin Slab", "Crete Round"]
  end

  def geometric_sans
    ["Century Gothic", "Exo", "Futura", "Raleway", "Roboto", "Roboto Condensed"]
  end

  def humanist_sans
    ["Cabin", "Droid Sans", "Lato", "Open Sans", "Verdana", "Fjalla One", "Ubuntu", "Oswald", "Alegreya Sans"]
  end

  def humanist_serif
    ["Palatino", "Crimson Text", "EB Garamond", "Cardo", "Merriweather", "Noto Serif"]
  end

  def modern_serif
    ["Playfair Display", "Monotype Bodoni", "Didot", "Old Standard TT", "Oranienbaum", "Gravitas One", "Vollkorn", "Volkov"]
  end

  def transitional_serif
    ["Baskerville", "Droid Serif", "Lora", "Poly", "Times New Roman", "Roboto Slab", "Noticia Text", ]
  end

  def transitional_sans
    ["Helvetica", "PT Sans", "Source Sans Pro" , "Trebuchet", "Istok Web", "Nobile"]
  end



  def random_color
    "%06x" % (rand * 0xffffff)
  end


  def self.palettes
    [
      ["Monochromatic", "Monochromatic" ],
      ["Analogous", "Analogous" ],
      ["Complimentary", "Complimentary" ],
    ]
  end


  def self.projects
    [
      ["Academia", "Academia" ],
      ["Architecture", "Architecture" ],
      ["Arts + Culture", "Arts + Culture" ],
      ["Education", "Education" ],
      ["Government", "Government" ],
      ["History", "History" ],
      ["Journalism", "Journalism" ],
      ["Legal", "Legal" ],
      ["Marketing", "Marketing" ],
      ["Promotional", "Promotional" ],
      ["Science", "Science" ],
      ["Technology", "Technology"],
      ["Transportation", "Transportation"]
    ]
  end

  def self.colors
    [
      ["Red", "Red" ],
      ["Orange", "Orange" ],
      ["Yellow", "Yellow" ],
      ["Green", "Green" ],
      ["Blue", "Blue" ],
      ["Purple", "Purple" ],
      ["Pink", "Pink" ]
    ]
  end

end
