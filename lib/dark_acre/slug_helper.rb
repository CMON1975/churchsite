module SlugHelper
  def generate_slug(string)
    string.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
end