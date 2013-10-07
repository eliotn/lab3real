class MoviesController < ApplicationController
  def initialize
    @all_ratings = Movie.all_ratings
    @defaults = Hash.new
    defaultratings = Hash[@all_ratings.map { |rating| [rating, 1] }]
    @defaults[:ratings] = defaultratings
    @defaults[:sort] = nil
    super
  end
  def index
    handle_session()
    #setup all the ratings or the selected ratings
    @movies = Movie.order(params[:sort]).restrict_by_rating(params[:ratings])
    if params[:sort] == "title"
	@movies.sort! {|x, y| x.title.downcase <=> y.title.downcase}
    end
  end
  
  def handle_session
    #prevent an infinite redirect loop
    if flash[:redirect] == 1
	return
    end
    @defaults.keys.each do |param|
	if params[param] == nil
	    if session[param] == nil
                #default if none in session or params
		params[param] = @defaults[param]
	    else
		#otherwise copy from the session
		params[param] = session[param]
	    end
        end
	session[param] = params[param]
        
    end

    #redirect
    flash.keep
    flash[:redirect] = 1
    
    redirect_to session
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
