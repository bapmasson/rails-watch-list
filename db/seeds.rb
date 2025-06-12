# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "open-uri"
require "json"

url = "https://tmdb.lewagon.com/movie/popular"

movies_serialized = URI.parse(url).read
movies_json = JSON.parse(movies_serialized)
movies = movies_json["results"]

puts "Destroying all movies..."
Movie.destroy_all
puts "Movies left in database: #{Movie.count}"

puts "Creating movies..."
movies.each do |movie|
  Movie.create!(
    title: movie["original_title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie['poster_path']}",
    rating: movie["vote_average"].round(1)
  )
  puts "Created movie: #{movie['original_title']}" if Movie.last.title == movie["original_title"]
end


puts "Finished! Movies created: #{Movie.count}"
