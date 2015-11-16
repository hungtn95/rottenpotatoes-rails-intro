class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.uniq.pluck(:rating) 
    flash.keep and redirect_to movies_path(ratings: session[:ratings], order: session[:sort_by], submit: 'Refresh') if params[:ratings].nil? and params[:sort_by].nil?
    session[:ratings] = params[:ratings] if !params[:ratings].nil?
    @selected_ratings = (!session[:ratings].nil? ? session[:ratings].keys : @all_ratings)
    session[:sort_by] = params[:sort_by] if !params[:sort_by].nil?
    @movies = Movie.order(session[:sort_by]).where(:rating => @selected_ratings)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
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
