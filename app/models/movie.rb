class Movie < ActiveRecord::Base
  def self.all_ratings
    ['G', 'PG', 'PG-13', 'R']
  end
  def self.restrict_by_rating(ratings)
    selected_ratings = ratings == nil ? [] : ratings.keys
    
    selected_ratings.map! { |rating| "movies.rating = \'" + rating + "\'" }
    
    selected_ratings = selected_ratings.join(" OR ")
    
    self.where(selected_ratings)
  end
end
